# frozen_string_literal: true

module Graphics
  module Instrument
    class MeasurementsController < ApplicationController
      include ActionView::Layouts
      include ActionController::Rendering

      def index
        @temperature_measurements = ::Instrument::Measurement.temperature.eligible_for_chart
        @humidity_measurements = ::Instrument::Measurement.humidity.eligible_for_chart
        @ph_measurements = ::Instrument::Measurement.ph.eligible_for_chart

        @temperature_measurements_grouped_by_hour = @temperature_measurements.group_by_hour(:measured_at)
                                                                             .average(:value)

        @humidity_measurements_grouped_by_hour = @humidity_measurements.group_by_hour(:measured_at)
                                                                       .average(:value)

        @ph_measurements_grouped_by_hour = @ph_measurements.group_by_hour(:measured_at)
                                                           .average(:value)

        @quantities_of_measurements_collected = ::Instrument::Measurement.eligible_for_chart
                                                                         .group(:quality)
                                                                         .count

        @temperature_measurements_grouped_by_day = @temperature_measurements.group_by_day(:measured_at)
                                                                            .count

        @humidity_measurements_grouped_by_day = @humidity_measurements.group_by_day(:measured_at)
                                                                      .count

        @ph_measurements_grouped_by_day = @ph_measurements.group_by_day(:measured_at)
                                                          .count

        render 'graphics/instrument/measurements/index'
      end
    end
  end
end
