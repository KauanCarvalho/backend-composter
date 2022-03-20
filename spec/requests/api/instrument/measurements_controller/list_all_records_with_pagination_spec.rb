# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/instrument/measurements/list_all_records_with_pagination', type: :request do
  let(:parsed_body) { JSON.parse(response.body, symbolize_names: true) }

  subject(:request) { get list_all_records_with_pagination_api_instrument_measurements_path }

  context 'when there is no record for the page' do
    let(:page) { 2 }

    before { Instrument::Measurement.delete_all }

    it 'it is expected to return an empty list' do
      request

      expect(response).to have_http_status(:ok)
      expect(parsed_body).to be_empty
    end
  end

  context 'when there is record for the page' do
    let(:page) { 1 }

    before do
      create(:instrument_measurement, :temp)
      create(:instrument_measurement, :humidity)
      create(:instrument_measurement, :p_h)
    end

    it 'it is expected to return a measurements list' do
      request

      expect(response).to have_http_status(:ok)
      expect(parsed_body).not_to be_empty
    end
  end
end
