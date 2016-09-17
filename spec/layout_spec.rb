require 'spec_helper'

describe StrokeCounter::Keyboard::Layout do
  let(:layout) { StrokeCounter::Keyboard::Layout.new }
  describe '#has_key?' do
    it 'should return true for "q"' do
      expect( layout.has_key?('q') ).to be(true)
    end
  end
end
