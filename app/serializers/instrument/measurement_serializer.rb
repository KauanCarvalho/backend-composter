# frozen_string_literal: true

module Instrument
  class MeasurementSerializer < ApplicationSerializer
    attributes :id, :measured_at, :value, :created_at, :updated_at
  end
end
