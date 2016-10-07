module StrokeCounter
  class Typist
    class Brain
      class NoCompatiblePattern < StandardError; end
      CONF = {
        anpan: Anpan::An::CONF,
        google: Anpan::An::GOOGLE_JAPANESE,
        normal: Anpan::An::GOOGLE_JAPANESE,
      }.freeze
      def initialize(mode: :normal)
        @mode = mode
        @mode = :normal unless CONF.keys.include? @mode

        conf = CONF[@mode]

        @table = Anpan.new(conf).table.map { |pat|
          pat[:efficiency] = pat[:output].to_s.size / pat[:input].to_s.size.to_f
          pat
        }
      end

      def to_keys(input)
        keys = []
        until input.empty?
          begin
            pat = best_pattern_for(input: input)
          rescue
            pat = { input: input[0], output: input[0] }
          end
          keys << pat[:input].to_s[@rest.to_s.size..-1] if pat
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
        pats = patterns.select { |pattern| pattern[:input].to_s.start_with? @rest.to_s }
        pats = compatible_patterns(input: input, patterns: pats)
        pats = pats.select do |pattern|
          compatible_with_next(input[pattern[:output].size..-1].to_s, pattern[:addition].to_s)
        end
        pat = pats.max_by { |pattern| efficiency_with_next(input: input, pattern: pattern) }
        @rest = pat.nil? ? nil : pat[:addition]
        raise NoCompatiblePattern, "No compatible pattern for '#{input[0]}'" if pat.nil?
        pat
      end

      def efficiency_with_next(input: '', pattern: {})
        next_input = input[pattern[:output].size..-1]
        patterns = compatible_patterns(input: next_input)
        next_pattern = best_score_pattern(patterns: patterns)
        next_output  = next_pattern.nil? ? 0 : next_pattern[:output].to_s
        next_input   = next_pattern.nil? ? 0 : next_pattern[:input].to_s
        (next_output.size + pattern[:output].to_s.size) / (next_input.size + pattern[:input].to_s.size).to_f
      end

      def compatible_with_next(input, addition)
        return true if input.empty?
        compatible_patterns(input: input).find { |pat| pat[:input].to_s.start_with? addition.to_s }
      end
    end
  end
end
