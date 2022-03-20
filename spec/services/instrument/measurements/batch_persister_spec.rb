# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Instrument::Measurements::BatchPersister, type: :service do
  describe '#perform' do
    subject(:execute) { described_class.new(params).perform }

    context 'when the update_date is not passed' do
      let(:params) { { update_date: nil } }
      let(:expected_error_message) { 'Measured at can\'t be blank' }

      it 'is expected to return an error' do
        response = execute

        expect(response[:success]).to eq(false)
        expect(response[:errors]).to include(expected_error_message)
      end
    end

    context 'when the update_date is passed' do
      context 'when update_date cannot be a `Datetime`' do
        let(:params) { { update_date: 'foo-bar' } }
        let(:expected_error_message) { "invalid datetime informed in updateDate - #{params[:update_date]}" }

        it 'is expected to return an error' do
          response = execute

          expect(response[:success]).to eq(false)
          expect(response[:errors]).to include(expected_error_message)
        end
      end

      context 'when update_date can be a `Datetime`' do
        let(:update_date) { '16/03/2022 18:39:42' }

        context 'when no measurements are passed' do
          let(:params) do
            {
              update_date: update_date,
              sensor_reading: nil
            }
          end
          let(:expected_error_message) { 'no measurement reported' }

          it 'is expected to return an error' do
            response = execute

            expect(response[:success]).to eq(false)
            expect(response[:errors]).to include(expected_error_message)
          end
        end

        context 'when measurements are passed' do
          context 'when there is an error with the measurements passed, the quality is wrong' do
            let(:params) do
              {
                update_date: update_date,
                sensor_reading: { i_am_not_valid: 2.0 }
              }
            end
            let(:expected_error_message) { 'Instrument: 1, Quality is not included in the list' }

            it 'is expected to return an error' do
              response = execute

              expect(response[:success]).to eq(false)
              expect(response[:errors]).to include(expected_error_message)
            end
          end

          context 'when there is an error with the measurements passed, the value is not present' do
            let(:params) do
              {
                update_date: update_date,
                sensor_reading: { temp: nil }
              }
            end
            let(:expected_error_message) { "Instrument: 1, Value can't be blank" }

            it 'is expected to return an error' do
              response = execute

              expect(response[:success]).to eq(false)
              expect(response[:errors]).to include(expected_error_message)
            end
          end

          context 'when there is not an error with the measurements passed' do
            let(:params) do
              {
                update_date: update_date,
                sensor_reading: { temp: 1.0, p_h: 2.0 }
              }
            end

            it 'is expected to return success' do
              response = execute

              expect(response[:success]).to eq(true)
              expect(response[:measurements]).to all be_an_instance_of(Instrument::Measurement)
            end
          end
        end
      end
    end
  end
end
