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
end
