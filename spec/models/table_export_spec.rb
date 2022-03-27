# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TableExport, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:related_table) }

    it { is_expected.to allow_value('instrument_measurements').for(:related_table) }

    it { is_expected.not_to allow_value('foo-bar').for(:related_table) }
  end
end
