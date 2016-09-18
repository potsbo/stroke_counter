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
    { left: left_strokes.size / @logs.size.to_f, right: right_strokes.size / @logs.size.to_f,
      probabilities: probabilities
    }
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
    hand   = nil
    counts = { r2l: 0, l2r: 0 }
    size   = { right: 0, left: 0}
    @logs.each do |log|
      size[log[:hand]] += 1
      counts[:r2l] += 1 if hand == :right && log[:hand] == :left
      counts[:l2r] += 1 if hand == :left  && log[:hand] == :right
      hand = log[:hand]
    end
    size[hand] -= 1

    { left_to_right: counts[:l2r] / size[:left], right_to_left:  counts[:r2l] / size[:right] }
  end
end
