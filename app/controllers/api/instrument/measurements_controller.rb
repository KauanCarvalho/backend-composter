# frozen_string_literal: true

module Api
  module Instrument
    class MeasurementsController < ApplicationController
      def create_in_batch
        response = ::Instrument::Measurements::BatchPersister.new(permitted_params_for_batch.to_unsafe_hash).perform

        if response[:success]
          render json: response[:measurements], status: :ok
        else
          render json: response, status: :unprocessable_entity
        end
      end

      private

      def permitted_params_for_batch
        params.deep_transform_keys(&:underscore).require(:data).permit(:update_date, sensor_reading: %i[temp humidity p_h])
      end
    end
  end
end
