module StrokeCounter
  class Typist
    class Brain
      def initialize(mode: :normal)
        conf = mode == :normal ? Anpan::GOOGLE_JAPANESE : Anpan::CONF
        @table = Anpan.new(conf).table
      end

      def to_keys(input)
        keys = []
        while !input.empty?
          pat   = best_pattern_for(input)
          keys << pat[:input].to_s if pat
          input = input[pat[:output].size..-1]
        end
        keys.join
      end

      def best_pattern_for(input)
        pats = @table.select do |pattern|
          input.start_with? pattern[:output]
        end
        pats.reverse!
        pats = pats.sort_by { |pattern| pattern[:output].to_s.size / pattern[:input].to_s.size.to_f }
        pats.last
      end
    end
  end
end