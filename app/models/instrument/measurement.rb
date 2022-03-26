# frozen_string_literal: true

module Instrument
  class Measurement < ApplicationRecord
    POSSIBLE_QUALITIES = %w[temp humidity p_h].freeze
    LIMIT_DATE_FOR_CHART = 2.months.freeze

    validates :measured_at, :quality, :value, presence: true
    validates :quality, inclusion: { in: POSSIBLE_QUALITIES }

    self.per_page = 10

    scope :temperature, -> { where(quality: 'temp') }
    scope :humidity, -> { where(quality: 'humidity') }
    scope :ph, -> { where(quality: 'p_h') }
    scope :eligible_for_chart, -> { where('measured_at >= ?', LIMIT_DATE_FOR_CHART.ago) }
  end
end
