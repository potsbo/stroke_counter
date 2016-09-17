module StrokeCounter
  class Keyboard
    class Layout

      DEFAULT = :qwerty
      attr_reader :name
      def initialize(args = {} )
        @name = ( args[:name].presence || DEFAULT ).downcase.to_sym
        initialize_with_name
      end

      def initialize_with_name(name = @name)
        @rows = [
            %i(q w e r t y u i o p),
            %i(a s d f g h j k l ;),
            %i(z x c v b n m , . /)
        ].freeze

        @left_side  = @rows.map { |row| row[0...5] }
        @right_side = @rows.map { |row| row[4...9] }
      end

      def has_key?(key, on: nil)
        case on
          when :right
            return @right_side.flatten.include?(key.to_sym)
          when nil
            return @rows.flatten.include?(key.to_sym)
          when :left
            return @left_side.flatten.include?(key.to_sym)
          else
            return false
        end
      end
    end
  end
end

