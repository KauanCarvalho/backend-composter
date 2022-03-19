# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /', type: :request do
  let(:parsed_body) { JSON.parse(response.body, symbolize_names: true) }

  let(:expected_body) do
    {
      app: 'backend-composter',
      description: 'APP responsible for persisting data from physical instruments in the field'
    }
  end

  subject(:request) { get root_path }

  # As it is not an endpoint with logic, there are no variations, so we don't need to break into contexts.
  it 'is expected to return the fields defined with your messages with :ok http status' do
    request

    expect(response).to have_http_status(:ok)
    expect(parsed_body).to eq(expected_body)
  end
end
