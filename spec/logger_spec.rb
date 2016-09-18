require 'spec_helper'

describe StrokeCounter::Keyboard::Logger do
  let(:logger) { StrokeCounter::Keyboard::Logger.new }
  it 'should be able to store feedback log' do
    expect(logger).not_to be_nil
  end

  describe '#add_log' do
    it 'should store logs' do
      expect(logger.add_log({})).to be_truthy
    end

    it 'should change log size' do
      expect{ logger.add_log({}) }.to change{ logger.logs.size }.by(1)
    end
  end

  describe '#analyze' do
    let(:result) { logger.analyze }
    it 'should return a Hash' do
      expect(logger.analyze).to be_a Hash
    end
    it 'should return a Hash' do
      expect(logger.analyze.keys).to include :left, :right
    end

    context 'when 10 right hand stroke were logged' do
      before do
        10.times { |_| logger.add_log({ hand: :right, finger: :index }) }
      end
      it 'should return 1 for right hand ratio' do
        expect(result[:right]).to eq(1)
      end
      it 'should return 0 for left hand ratio' do
        expect(result[:left]).to eq(0)
      end
    end

    context 'when no logs given' do
      it 'should return nil for both hand ratio' do
        expect(result[:left]).to be_nil
        expect(result[:right]).to be_nil
      end
    end
  end

  describe '#probabilities' do
    let(:result) { logger.probabilities }
    it 'should return a Hash' do
      expect(result).to be_a Hash
    end
    context 'when left index finger used 100 times' do
      before do
        100.times { logger.add_log( { hand: :left, finger: :index} ) }
      end
      it 'should be 0 to change left to right' do
        expect(result[:left_to_right]).to be_zero
      end
    end

    context 'when alternate right and left typed' do
      before do
        100.times do
          logger.add_log({ hand: :left, finger: :index})
          logger.add_log({ hand: :right, finger: :index})
        end
      end
      it 'should be 1 to change left to right' do
        expect(result[:left_to_right]).to be(1)
        expect(result[:right_to_left]).to be(1)
      end
    end
  end
end
