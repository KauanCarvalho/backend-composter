# frozen_string_literal: true

module Instrument
  module Measurements
    class BatchPersister
      include ActiveModel::Validations

      validates :measured_at, presence: true

      with_options if: -> { measured_at.present? && measured_at_is_a_datetime? } do
        validate :validate_measurements
      end

      def initialize(params)
        @params = params

        # This date represents the measurement datetime.
        @measured_at = params[:update_date]

        # This represents a list (array) of measurements.
        @measurements = define_measurements(params[:sensor_reading].presence || [])
      end

      def perform
        return { errors: errors.full_messages, success: false } unless valid?

        measurements.each(&:save)

        { success: true, measurements: measurements }
      rescue StandardError => e
        { errors: [e.message], success: false }
      end

      private

      attr_reader :params, :measured_at, :measurements

      def define_measurements(measurements)
        measurements.map do |quality, value|
          Instrument::Measurement.new(quality: quality, value: value, measured_at: measured_at)
        end
      end

      def measured_at_is_a_datetime?
        DateTime.parse(measured_at)
        true
      rescue StandardError
        errors.add(:base, "invalid datetime informed in updateDate - #{measured_at}")
        false
      end

      def validate_measurements
        errors.add(:base, 'no measurement reported') if measurements.blank?

        measurements.each.with_index(1) do |measurement, index|
          next if measurement.valid?

          errors.add(:base, "Instrument: #{index}, #{measurement.errors.full_messages.to_sentence}")
        end
      end
    end
  end
end
