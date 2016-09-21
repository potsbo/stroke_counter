module StrokeCounter
  class Typist
    class Brain
      def initialize(mode: :normal)
        @table = Anpan.new.table
      end

      def to_keys(input)
        'aiueo'
      end
    end
  end
end