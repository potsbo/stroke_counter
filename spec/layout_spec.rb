require 'spec_helper'

describe StrokeCounter::Keyboard::Layout do
  let(:layout) { StrokeCounter::Keyboard::Layout.new }
  describe '#has_key?' do
    it 'should return true for "q"' do
      expect( layout.has_key?('q') ).to be(true)
    end

    it 'should be false q on the right side' do
      expect( layout.has_key?('q', on: :right)).to be(false)
    end

    it 'should be false :q (symbol) on the right side' do
      expect( layout.has_key?(:q, on: :right)).to be(false)
    end

    describe 'key :f' do
      it 'should return true for :f (symbol) on the right side' do
        expect( layout.has_key?(:f, on: :right) ).to be(false)
      end
      it 'should return true for :f (symbol) on the right side' do
        expect( layout.has_key?(:f, on: :left) ).to be(true)
      end
    end

    describe 'key :h' do
      it 'should return true for :h (symbol) on the right side' do
        expect( layout.has_key?(:h, on: :right) ).to be(true)
      end
      it 'should return true for :h (symbol) on the right side' do
        expect( layout.has_key?(:h, on: :left) ).to be(false)
      end
    end
  end

  describe '#name' do
    it 'should be :qwerty for no initializer option' do
      expect(layout.name).to be(:qwerty)
    end
  end
end
