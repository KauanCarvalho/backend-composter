# frozen_string_literal: true

module Api
  module Instrument
    class MeasurementsController < ApplicationController
      def create_in_batch
        response = ::Instrument::Measurements::BatchPersister.new(permitted_params_for_batch).perform

        if response[:success]
          render json: response[:measurements],
                 root: false,
                 each_serializer: ::Instrument::MeasurementSerializer,
                 status: :ok
        else
          render json: response, status: :unprocessable_entity
        end
      end

      def list_all_records_with_pagination
        measurements_list = ::Instrument::Measurement.paginate(page: page).order('created_at DESC')

        render json: measurements_list,
               root: false,
               each_serializer: ::Instrument::MeasurementSerializer,
               status: :ok
      end

      private

      def permitted_params_for_batch
        params
          .require('data')
          .permit('updateDate', 'sensorReading' => %i[temp humidity pH])
          .to_unsafe_hash.deep_transform_keys(&:underscore)
          .deep_symbolize_keys
      end

      def page
        params.permit(:page)[:page] || 1
      end
    end
  end
end
