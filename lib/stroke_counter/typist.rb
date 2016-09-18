class StrokeCounter::Typist
  VALID_MODE = %i(normal qwerty dvorak)
  attr_reader :mode

  def initialize(args = {})
    @mode = args[:mode]
    @mode = :qwerty if @mode == :normal
    @mode = :qwerty unless VALID_MODE.include? @mode

    @logger = StrokeCounter::Keyboard::Logger.new(name: @mode)
    @keyboard = StrokeCounter::Keyboard.new
  end

  def type_keys(str)
    str.each_char { |c| type_key(c.to_sym) }
    self
  end

  def type_key(char)
    @logger.add_log @keyboard.type_feedback(char)
    self
  end

  def log
    @logger.logs
  end

  def result
    @logger.analyze
  end
end