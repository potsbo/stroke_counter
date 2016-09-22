module StrokeCounter
  class Typist
    class Brain
      def initialize(mode: :normal)
        conf = mode == :normal ? Anpan::GOOGLE_JAPANESE : Anpan::CONF
        @table = Anpan.new(conf).table.map { |pat|
          pat[:efficiency] = pat[:output].to_s.size / pat[:input].to_s.size.to_f
          pat
        }
      end

      def to_keys(input)
        keys = []
        until input.empty?
          pat   = best_pattern_for(input: input)
          keys << pat[:input].to_s[@rest.size..-1] if pat
          input = input[pat[:output].size..-1]
        end
        keys.join
      end

      def compatible_patterns(input: '', patterns: @table)
        patterns.select{ |pattern| input.start_with?(pattern[:output].to_s) && pattern[:output].present?}
      end

      def best_score_pattern(input: input, patterns: @table)
        patterns.max_by{ |pattern| pattern[:efficiency] }
      end

      def best_pattern_for(input: '', patterns: @table)
        pats = patterns.select { |pattern| pattern[:input].to_s.start_with? @rest.to_s }
        pats = pats.select { |pattern| input.start_with? pattern[:output] }
        pats = pats.select do |pattern|
          compatible_with_next(input[pattern[:output].size..-1].to_s,pattern[:addition].to_s)
        end
        puts pats.map { |pattern| [pattern, efficiency_with_next(input: input, pattern: pattern)] }
        pat = pats.max_by { |pattern| efficiency_with_next(input: input, pattern: pattern) }
        @rest = pat[:addition]
        pat
      end

      def efficiency_with_next(input: '', pattern: {})
        next_input = input[pattern[:output].size..-1]
        patterns = compatible_patterns(input: next_input)
        next_pattern = best_score_pattern(input: next_input, patterns: patterns)
        next_output  = next_pattern.nil? ? 0 : next_pattern[:output].to_s
        next_input   = next_pattern.nil? ? 0 : next_pattern[:input].to_s
        (next_output.size + pattern[:output].to_s.size) / (next_input.size + pattern[:input].to_s.size).to_f
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