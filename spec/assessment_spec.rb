require 'spec_helper'

describe StrokeCounter::Typist::Assessment do
  let(:klass) { Struct.new(nil) { include StrokeCounter::Typist::Assessment } }
  let(:assessment) { klass.new }

  describe '#text_file' do
    let(:text_file) { assessment.text_file }
    it 'should return path to file name' do
      expect(text_file).to be_a File
    end
  end
end

