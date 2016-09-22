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
          keys << pat[:input].to_s[@rest.size..-1] if pat
          input = input[pat[:output].size..-1]
        end
        keys.join
      end

      def best_pattern_for(input)
        pats = @table.select do |pattern|
          pattern[:input].to_s.start_with? @rest.to_s
        end
        pats = pats.select do |pattern|
          input.start_with? pattern[:output]
        end
        pats = pats.select do |pattern|
          compatible_with_next(input[pattern[:output].size..-1].to_s,pattern[:addition].to_s)
        end
        pat = pats.max_by { |pattern| pattern[:output].to_s.size / pattern[:input].to_s.size.to_f }
        @rest = pat[:addition]
        pat
      end

      def compatible_with_next(input, addition)
        return true if input.empty?
        pats = @table.select do |pattern|
          input.start_with? pattern[:output]
        end
        pats.find { |pat| pat[:input].to_s.start_with? addition.to_s}
      end
    end
  end
end