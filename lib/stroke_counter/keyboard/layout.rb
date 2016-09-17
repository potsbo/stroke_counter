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

      def left_side_keys
        @left_side.flatten
      end

      def right_side_keys
        @right_side.flatten
      end

      def keys
        @rows.flatten
      end

      def has_key_on(key)
        key = key.to_sym
        return :left if left_side_keys.include? key
        return :right if right_side_keys.include? key
        nil
      end

      def finger_by_key(key)
        finger_by_index index_by_key(key)
      end

      def index_by_key(key)
        @rows.each do |row|
          index = row.index(key)
          return index if index.present?
        end
      end

      def finger_by_index(index)
        index = 9 - index if index > 4
        %i(little ring middle index index)[index]
      end
    end
  end
end

