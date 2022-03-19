# frozen_string_literal: true

module Instrument
  class Measurement < ApplicationRecord
    POSSIBLE_TYPES = %w[temp humidity pH].freeze

    validates :measured_at, :type, :value, presence: true
    validates :type, inclusion: { in: POSSIBLE_TYPES }
  end
end
