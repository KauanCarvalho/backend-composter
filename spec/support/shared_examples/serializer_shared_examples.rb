# frozen_string_literal: true

shared_examples 'a serializable object' do |attrs|
  it { expect(subject.attributes.keys).to match_array(attrs) }
end
