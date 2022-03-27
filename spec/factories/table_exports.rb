# frozen_string_literal: true

FactoryBot.define do
  factory :table_export, class: TableExport do
    trait :with_table do
      related_table { Instrument::Measurement.table_name }
    end
  end
end
