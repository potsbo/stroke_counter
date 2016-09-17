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
  end
end
