require 'spec_helper'

describe StrokeCounter::Typist::Assessment do
  let(:klass) { Struct.new(nil) { include StrokeCounter::Typist::Assessment } }
  let(:assessment) { klass.new }

  describe '#path_to_file' do
    it 'should return string' do
      expect(assessment.path_to_file).to be_a String
    end
    it 'should return path to constitution_of_japan.txt' do
      expect(assessment.path_to_file).to end_with 'constitution_of_japan.txt'
    end
    context 'when some_file_name given' do
      it 'should return path to some_file_name' do
        expect(assessment.path_to_file('some_file_name')).to end_with 'some_file_name'
      end
    end
  end

  describe '#text_file' do
    let(:text_file) { assessment.text_file }
    it 'should return path to file name' do
      expect(text_file).to be_a File
    end
  end
end
