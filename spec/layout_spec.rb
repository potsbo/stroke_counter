require 'spec_helper'

describe StrokeCounter::Keyboard::Layout do
  let(:name) { :qwerty }
  let(:layout) { StrokeCounter::Keyboard::Layout.new(name: name) }

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
    settings = %i(qwerty dvorak colemak)
    settings.each do |setting|
      context "when layout name is #{setting} " do
        let(:name) { setting }
        it 'should contain 30 characters' do
          expect(layout.keys.size).to be 30
        end

        it 'should contain all 26 alphabets' do
          expect((:a..:z).to_a - layout.keys).to eq []
        end
      end
    end
  end

  describe '#key_on' do
    let(:side) { layout.key_on key }
    let(:key) { :a }
    it 'should return right or left' do
      expect(side).to be :left
    end
  end

  describe '#finger_by_key' do
    key_fingers = {
      a: :little, s: :ring,  d: :middle, f: :index,  g: :index,
      h: :index,  j: :index, k: :middle, l: :ring, ';': :little
    }
    key_fingers.each do |key, finger|
      it "should return #{finger} for #{key}" do
        expect(layout.finger_by_key(key)).to be finger
      end
    end
  end

  describe '#finger_by_index' do
    fingers = %i(little ring middle index index index index middle ring little)
    fingers.each_with_index do |finger, index|
      it "should return #{finger} for #{index}" do
        expect(layout.finger_by_index(index)).to be finger
      end
    end

    context 'when nil given' do
      it 'should return nil' do
        expect(layout.finger_by_index(nil)).to be_nil
      end
    end
  end

  describe '#index_by_key' do
    context 'when a-z given' do
      (:a..:z).each do |c|
        it "should return Integer index for #{c}" do
          expect(layout.index_by_key(c)).to be_a Integer
        end
      end
    end

    context 'when not normal character given' do
      it 'should return nil' do
        expect(layout.index_by_key("\n")).to be_nil
      end
    end
  end
end
