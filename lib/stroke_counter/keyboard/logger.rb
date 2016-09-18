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
    { left: left_strokes.size / @logs.size.to_f, right: right_strokes.size / @logs.size.to_f }
  end

  def left_strokes
    hand_strokes(:left)
  end

  def right_strokes
    hand_strokes(:right)
  end

  def hand_strokes(hand)
    @logs.select { |log| log[:hand] == hand}
  end

  def probabilities
    { left_to_right: 0, right_to_left: 0 }
  end
end
