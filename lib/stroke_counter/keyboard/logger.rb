module StrokeCounter
  class Keyboard
    class Logger
      attr_reader :logs

      def initialize
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
        {
          hands: hands_ratio,
          probabilities: probabilities, keys_size: @logs.size, finger_frequency: finger_frequency,
          rows: rows_summary
        }
      end

      def hands_ratio
        logs_size = @logs.size.to_f
        { left: left_strokes.size / logs_size, right: right_strokes.size / logs_size }
      end

      # hand strokes
      def left_strokes
        hand_strokes(:left)
      end

      def right_strokes
        hand_strokes(:right)
      end

      def hand_strokes(hand)
        @logs.select { |log| log[:hand] == hand }
      end
      # hand strokes

      def finger_frequency(hand: nil)
        return finger_frequency_summary unless hand

        counts = { index: 0, middle: 0, ring: 0, little: 0 }
        hand_strokes(hand).each do |stroke|
          finger = stroke[:finger]
          counts[finger] += 1
        end
        counts
      end

      def finger_frequency_summary
        { left: finger_frequency(hand: :left), right: finger_frequency(hand: :right) }
      end

      def probabilities
        counts = hand_switch_counts
        size   = hand_switch_candidate_counts
        l2r = size[:left].zero? ?  nil : counts[:l2r] / size[:left].to_f
        r2l = size[:right].zero? ? nil : counts[:r2l] / size[:right].to_f
        { left_to_right: l2r, right_to_left: r2l }
      end

      def hand_switch_counts
        counts = { r2l: 0, l2r: 0 }
        hand   = nil
        @logs.each do |log|
          side = log[:hand]
          side = :other unless %i(right left).include? side
          counts[:r2l] += 1 if hand == :right && log[:hand] == :left
          counts[:l2r] += 1 if hand == :left  && log[:hand] == :right
          hand = side
        end
        counts
      end

      def hand_switch_candidate_counts
        size = { left: left_strokes.size, right: right_strokes.size }
        hand = @logs.last[:hand] unless @logs.empty?
        size[hand] -= 1 if hand
        size
      end

      def rows_summary
        hash = {}
        %i(upper middle lower).each do |row|
          hash[row] = row_strokes(row).size / @logs.size.to_f
        end
        hash
      end

      def row_strokes(row, logs: @logs)
        logs.select { |log| log[:row] == row }
      end
    end
  end
end
