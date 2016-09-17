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

  describe '#has_key_on' do
    let(:side) { layout.has_key_on key }
    let(:key) { :a }
    it 'should return right or left' do
      expect(side).to be :left
    end
  end
  describe '#finger_by_index' do
    fingers = %i(little ring middle index index index index middle ring little)
    fingers.each_with_index do |finger, index|
      it "should return #{finger} for #{index}" do
        expect(layout.finger_by_index(index)).to be finger
      end
    end
  end
end
