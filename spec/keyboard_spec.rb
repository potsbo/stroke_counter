require "spec_helper"

describe StrokeCounter::Keyboard do
  let(:args) { {} }
  let(:keyboard) { StrokeCounter::Keyboard.new(args) }
  describe '#name' do
    it 'should be qwerty without args' do
      expect(keyboard.name).to be(:qwerty)
    end

    context 'initialize with name :dvorak (symbol)' do
      let(:args) { { name: :dvorak } }
      it 'should be :dvorak' do
        expect(keyboard.name).to be(:dvorak)
      end
      context 'initialize with name "dvorak" (string)' do
        let(:args) { { name: 'dvorak' } }
        it 'should be :dvorak' do
          expect(keyboard.name).to be(:dvorak)
        end
      end
      context 'initialize with name "DVORAK" (string)' do
        let(:args) { { name: 'DVORAK' } }
        it 'should be :dvorak' do
          expect(keyboard.name).to be(:dvorak)
        end
      end
    end

    context 'initialize with name empty string' do
      let(:args) { { name: '' } }
      it 'should be :qwerty' do
        expect(keyboard.name).to be(:qwerty)
      end
    end
  end

  describe '#has_key?' do
    it 'should return true for "q"' do
      expect( keyboard.has_key?('q') ).to be(true)
    end

    it 'should be false q on the right side' do
      expect( keyboard.has_key?('q', on: :right)).to be(false)
    end

    it 'should be false :q (symbol) on the right side' do
      expect( keyboard.has_key?(:q, on: :right)).to be(false)
    end

    describe 'key :f' do
      it 'should return true for :f (symbol) on the right side' do
        expect( keyboard.has_key?(:f, on: :right) ).to be(false)
      end
      it 'should return true for :f (symbol) on the left side' do
        expect( keyboard.has_key?(:f, on: :left) ).to be(true)
      end
    end

    describe 'key :h' do
      it 'should return true for :h (symbol) on the right side' do
        expect( keyboard.has_key?(:h, on: :right) ).to be(true)
      end
      it 'should return true for :h (symbol) on the right side' do
        expect( keyboard.has_key?(:h, on: :left) ).to be(false)
      end
    end
  end

  describe '#type_feedback' do
    let(:feedback) { keyboard.type_feedback(key) }
    let(:key) { :a }
    it 'should return a Hash' do
      expect(feedback).to be_a Hash
    end

    it 'should contain :hand key' do
      expect(feedback.keys).to include(:hand)
    end

    it 'should contain :finger key' do
      expect(feedback.keys).to include(:finger)
    end

    describe 'hand key' do
      (:a..:z).each do |key|
        let(:key) { key }
        it 'should not be nil for a-z' do
          expect(feedback[:hand]).not_to be_nil
        end
      end

      { left:  %i(q w e r t a s d f g z x c v b),
        right: %i(y u i o p h j k l ; n m , . /),
      }.each do |side, keys|
        keys.each do |key|
          describe "#{side} side keys" do
            it "should have #{key} on the #{side}" do
              hand = keyboard.type_feedback(key)[:hand]
              expect(hand).to be side
            end
          end
        end
      end

      context 'when :a given' do
        let(:key) { :a }
        let(:hand) { feedback[:hand] }
        it 'should be done by left hand' do
          expect(hand).to be :left
        end
      end
    end

    describe 'finger key' do
      context 'when :a given' do
        let(:key) { :a }
        let(:finger) { feedback[:finger] }
        it 'should be :little' do
          expect(finger).to be :little
        end
      end
    end
  end
end
