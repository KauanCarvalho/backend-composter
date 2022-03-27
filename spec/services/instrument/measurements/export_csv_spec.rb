# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Instrument::Measurements::ExportCsv, type: :service do
  describe '#perform' do
    subject(:execute) { described_class.new.perform }

    context 'when there is no record' do
      before { Instrument::Measurement.delete_all }

      it 'expected to skip the process' do
        expect(subject).to eq(nil)
      end
    end

    context 'when there is record' do
      before do
        create(:instrument_measurement, :temp)
        create(:instrument_measurement, :humidity)
        create(:instrument_measurement, :p_h)
      end

      context 'when a file has already been generated today' do
        before { create(:table_export,  :with_table) }

        it 'expected to skip the process' do
          expect(subject).to eq(nil)
        end

        context 'when a file has not already been generated today' do
          before { TableExport.delete_all }

          it 'is expected to generate a file correctly' do
            result = subject

            # Should return TableExport instance.
            expect(result).to be_instance_of(TableExport)

            # Check if everything is as it should.
            expect(result.related_table).to eq(Instrument::Measurement.table_name)
            expect(result.csv_file).to be_present

            # The generated value must be listed as current.
            expect(TableExport.created_today).to include(result)
          end
        end
      end
    end
  end
end
