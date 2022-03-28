# frozen_string_literal: true

return unless Rails.env.production?

Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_options = lambda do |event|
    rejected_params = %w[controller action]

    {
      params: event.payload[:params].reject { |k| rejected_params.include? k }
    }
  end
end
