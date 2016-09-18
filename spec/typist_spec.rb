require 'spec_helper'

describe StrokeCounter::Typist do
  let(:args) { {} }
  let(:typist) { StrokeCounter::Typist.new(args) }

  describe '#type_language' do
    it 'should respond to Japanese'
  end

  describe '#type_keys' do
    let(:string) { 'abcdefghijklmnopqrstuvwxyz' }
    it 'should respond to alphabets' do
      expect{ typist.type_keys(string) }.not_to raise_error
    end
  end

  describe '#log' do
    it 'should return an Array of Hash' do
      expect(typist.log).to be_a(Array)
    end
  end

  describe '#result' do
    it 'should be a Hash' do
      expect(typist.result).to be_a(Hash)
    end
  end

  describe '#mode' do
    it 'should return :qwerty' do
      expect(typist.mode).to be :qwerty
    end
    context 'when invalid mode given' do
      let(:args) { { mode: :invalid_mode } }
      it 'should return :qwerty' do
        expect(typist.mode).to be :qwerty
      end
    end
    context 'when dvorak mode given' do
      let(:args) { { mode: :dvorak } }
      it 'should return :dvorak' do
        expect(typist.mode).to be :dvorak
      end
    end
  end
end