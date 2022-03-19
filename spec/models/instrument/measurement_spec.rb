# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Instrument::Measurement, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:measured_at) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:value) }

    it { is_expected.to allow_value('temp').for(:type) }
    it { is_expected.to allow_value('humidity').for(:type) }
    it { is_expected.to allow_value('pH').for(:type) }

    it { is_expected.not_to allow_value('foo-bar').for(:type) }
  end
end
