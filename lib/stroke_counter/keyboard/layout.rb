module StrokeCounter
  class Keyboard
    class Layout

      DEFAULT = :qwerty
      attr_reader :name
      def initialize(args = {} )
        @name = ( args[:name].presence || DEFAULT ).downcase.to_sym
      end

      def has_key?(key)
        true
      end
    end
  end
end

