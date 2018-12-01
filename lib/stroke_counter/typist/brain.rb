module StrokeCounter
  class Typist
    class Brain
      attr_reader :mode
      ROMAJI_TABLES = {
        anpan:  'anpan.yaml',
        google: 'google_japanese_input.yaml',
      }.freeze

      def initialize(mode: :normal)
        @mode = mode

        conf = ROMAJI_TABLES[@mode] || ROMAJI_TABLES[:google]

        @table = Anpan.new(conf).table
        @table.each do |pat|
          pat[:efficiency] = pat[:output].to_s.size / pat[:input].to_s.size.to_f
        end
      end

      def to_keys(input)
        keys = []
        until input.empty?
          pat = best_pattern_for(input: input) || { input: input[0], output: input[0] }
          keys << pat[:input].to_s[@rest.to_s.size..-1]
          input = input[pat[:output].size..-1]
        end
        keys.join
      end

      def compatible_patterns(input: '', patterns: @table)
        patterns.select { |pattern| input.start_with?(pattern[:output].to_s) && pattern[:output].present? }
      end

      def best_score_pattern(patterns: @table)
        patterns.max_by { |pattern| pattern[:efficiency] }
      end

      def best_pattern_for(input: '', patterns: @table)
        candidates = candidate_patterns(input: input, patterns: patterns)
        pat = candidates.max_by { |pattern| efficiency_with_next(input: input, pattern: pattern) }
        @rest = pat.nil? ? nil : pat[:addition]
        pat
      end

      def candidate_patterns(input: '', patterns: @table)
        pats = compatible_patterns(input: input, patterns: patterns)
        pats.select do |pattern|
          compatible_with_next(input[pattern[:output].size..-1].to_s, pattern[:addition].to_s)
        end
      end

      def efficiency_with_next(input: '', pattern: {})
        output_size = pattern[:output].size
        next_pattern = best_score_pattern(patterns: compatible_patterns(input: input[output_size..-1]))
        complex_efficiency(patterns: [pattern, next_pattern])
      end

      def complex_efficiency(patterns: [])
        output_size = 0
        input_size  = 0
        patterns.compact.each do |pattern|
          input_size  += pattern[:input].size
          output_size += pattern[:output].size
        end
        output_size / input_size.to_f
      end

      def compatible_with_next(input, addition)
        return true if input.empty?
        compatible_patterns(input: input).find { |pat| pat[:input].to_s.start_with? addition.to_s }
      end
    end
  end
end
