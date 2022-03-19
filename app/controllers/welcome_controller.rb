# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    render json: I18n.t('default-body', scope: %w[welcome-controller]), status: :ok
  end
end
