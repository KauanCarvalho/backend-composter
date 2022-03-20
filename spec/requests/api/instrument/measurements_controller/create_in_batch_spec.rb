# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/instrument/measurements/create_in_batch', type: :request do
  let(:parsed_body) { JSON.parse(response.body, symbolize_names: true) }

  subject(:request) { post create_in_batch_api_instrument_measurements_path, params: params }

  context 'when there is something wrong in the processing of information' do
    # In this case, the measurement date entered is invalid.
    let(:params) do
      {
        'data' => {
          'updateDate' => 'i am not a vlid datetime, bazinga!',
          'sensorReading' => {
            'temp' => 17.97,
            'humidity' => 20.22,
            'pH' => 5.92
          }
        }
      }
    end

    it 'is expected to return error and HTTP status 422' do
      request

      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_body[:errors]).to be_present
    end
  end

  context 'when everything is persisted as we wanted' do
    let(:params) do
      {
        'data' => {
          'updateDate' => '16/03/2022 18:39:42',
          'sensorReading' => {
            'temp' => 17.97,
            'humidity' => 20.22,
            'pH' => 5.92
          }
        }
      }
    end

    it 'is expected to return success and HTTP status 200' do
      measurements_before_request = Instrument::Measurement.count
      quantity_to_be_persited = params['data']['sensorReading'].size

      request

      expect(response).to have_http_status(:ok)
      expect(parsed_body.size).to eq(quantity_to_be_persited)
      expect(Instrument::Measurement.count).to eq(measurements_before_request + quantity_to_be_persited)
    end
  end
end
