# frozen_string_literal: true

FactoryBot.define do
  factory :instrument_measurement, class: Instrument::Measurement do
    measured_at { DateTime.current }
    value       { rand(-100.0..100.00) }

    trait :temp do
      quality { 'temp' }
    end

    trait :humidity do
      quality { 'humidity' }
    end

    trait :p_h do
      quality { 'p_h' }
    end
  end
end
