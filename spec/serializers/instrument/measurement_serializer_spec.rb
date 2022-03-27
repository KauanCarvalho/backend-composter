# frozen_string_literal: true

require 'rails_helper'

describe Instrument::MeasurementSerializer do
  subject { described_class.new(instrument_measurement) }

  let(:instrument_measurement) { create(:instrument_measurement, :temp) }

  it_behaves_like 'a serializable object', %i[
    id
    measured_at
    value
    created_at
    updated_at
  ]

  describe '#as_json' do
    subject { described_class.new(instrument_measurement).as_json }

    it { expect(subject[:id]).to eq(instrument_measurement.id) }
    it { expect(subject[:measured_at]).to eq(instrument_measurement.measured_at) }
    it { expect(subject[:value]).to eq(instrument_measurement.value) }
    it { expect(subject[:created_at]).to eq(instrument_measurement.created_at) }
    it { expect(subject[:updated_at]).to eq(instrument_measurement.updated_at) }

    it 'returns the correctly reservations with the correct serializer' do
      is_expected.to match_json_schema('instrument_measurement')
    end
  end
end
