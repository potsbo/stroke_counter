class StrokeCounter::Typist
  def initialize(args = {})
    @logger = StrokeCounter::Keyboard::Logger.new
    @keyboard = StrokeCounter::Keyboard.new
  end

  def type_keys(str)
    str.each_char { |c| type_key(c.to_sym) }
  end

  def type_key(char)
    @logger.add_log @keyboard.type_feedback(char)
  end

  def log
    @logger.logs
  end

  def result
    @logger.analyze
  end
end