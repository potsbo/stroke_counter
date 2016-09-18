class StrokeCounter::Typist
  def initialize(args = {})
    @logger = StrokeCounter::Keyboard::Logger.new
  end

  def log
    @logger.logs
  end

  def result
    @logger.analyze
  end
end