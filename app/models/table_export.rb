# frozen_string_literal: true

class TableExport < ApplicationRecord
  POSSIBLE_RELATED_TABLE = %w[instrument_measurements].freeze

  has_one_attached :csv_file

  validates :related_table, presence: true
  validates :related_table, inclusion: { in: POSSIBLE_RELATED_TABLE }

  scope :created_today, -> { where(created_at: DateTime.now.all_day) }
end
