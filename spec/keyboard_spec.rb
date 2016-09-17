require "spec_helper"

describe StrokeCounter::Keyboard do
  let(:args) { {} }
  let(:keyboard) { StrokeCounter::Keyboard.new(args) }
  describe '#name' do
    it 'should be qwerty without args' do
      expect(keyboard.name).to be(:qwerty)
    end
  end
end
