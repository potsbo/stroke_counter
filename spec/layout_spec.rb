require 'spec_helper'

describe StrokeCounter::Keyboard::Layout do
  let(:layout) { StrokeCounter::Keyboard::Layout.new }

  describe '#left_side_keys' do
    it 'should contain 15 characters' do
      expect(layout.left_side_keys.size).to be 15
    end
  end

  describe '#right_side_keys' do
    it 'should contain 15 characters' do
      expect(layout.right_side_keys.size).to be 15
    end
  end

  describe '#keys' do
    it 'should contain 30 characters' do
      expect(layout.keys.size).to be 30
    end

    it 'should contain all 26 alphabets' do
      expect((:a..:z).to_a - layout.keys).to eq []
    end
  end
end
