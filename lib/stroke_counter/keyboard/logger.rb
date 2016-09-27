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
      probabilities: probabilities, keys_size: @logs.size,
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
    size   = { right: 0, left: 0, other: 0}
    @logs.each do |log|
      side = log[:hand]
      side = :other unless %i(right left).include? side
      size[side] += 1
      counts[:r2l] += 1 if hand == :right && log[:hand] == :left
      counts[:l2r] += 1 if hand == :left  && log[:hand] == :right
      hand = side
    end
    size[hand] -= 1 unless hand.nil?
    l2r = counts[:l2r] / size[:left].to_f  rescue nil
    r2l = counts[:r2l] / size[:right].to_f rescue nil
    { left_to_right: l2r, right_to_left: r2l }
  end
end
