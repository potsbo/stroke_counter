require 'spec_helper'

describe StrokeCounter::Typist::Brain do
  let(:brain) { StrokeCounter::Typist::Brain.new }
  describe '#to_keys' do
    let(:keys) { brain.to_keys(input) }
    let(:input) { "" }
    context 'when "あいうえお" given' do
      it 'should return aiueo for "あいうえお"' do
        expect(keys).to eq 'aiueo'
      end
    end
  end
end