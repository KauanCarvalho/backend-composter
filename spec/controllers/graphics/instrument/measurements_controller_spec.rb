# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Graphics::Instrument::MeasurementsController, type: :controller do
  describe 'GET index' do
    it 'renders the correct template' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(response).to render_template 'graphics/instrument/measurements/index'
    end
  end
end
