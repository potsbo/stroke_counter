module StrokeCounter
  class Typist
    class Brain
      def initialize(mode: :normal)
        conf = mode == :normal ? Anpan::GOOGLE_JAPANESE : Anpan::CONF
        @table = Anpan.new(conf).table
      end

      def to_keys(input)
        keys = ''
        input.each_char do |c|
          pat = @table.find do |pattern|
            pattern[:output] == c
          end
          keys += pat[:input].to_s if pat
        end
        keys
      end
    end
  end
end