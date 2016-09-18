class StrokeCounter::Keyboard::Logger
  attr_reader :logs

  def initialize(args = {})
    @logs = []
  end

  def add_log(log)
    if log.is_a? Hash
      @logs << log
      true
    else
      false
    end
  end

  def analyze
    return { left: nil, right: nil} if @logs.size == 0
    left_strokes  = @logs.select { |log| log[:hand] == :left  }
    right_strokes = @logs.select { |log| log[:hand] == :right }
    { left: left_strokes.size / @logs.size.to_f, right: right_strokes.size / @logs.size.to_f }
  end
end
