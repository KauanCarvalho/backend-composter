# frozen_string_literal: true

module Instrument
  class Measurement < ApplicationRecord
    POSSIBLE_QUALITIES = %w[temp humidity p_h].freeze

    validates :measured_at, :quality, :value, presence: true
    validates :quality, inclusion: { in: POSSIBLE_QUALITIES }
  end
end
