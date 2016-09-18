require 'spec_helper'

describe StrokeCounter::Typist do
  let(:typist) { StrokeCounter::Typist.new }

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
  end
end