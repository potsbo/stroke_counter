require 'stroke_counter/keyboard/layout/qwerty'
require 'stroke_counter/keyboard/layout/dvorak'
require 'stroke_counter/keyboard/layout/colemak'

module StrokeCounter
  class Keyboard
    class Layout
      DEFAULT = :qwerty
      PRESETS = {
        qwerty:  QWERTY,
        dvorak:  DVORAK,
        colemak: COLEMAK,
      }.freeze
      attr_reader :name
      def initialize(args = {} )
        @name = ( args[:name].presence || DEFAULT ).downcase.to_sym
        initialize_with_name
      end

      def initialize_with_name(name = @name)
        @rows = PRESETS[name]

        @left_side  = @rows.map { |row| row[0...5] }
        @right_side = @rows.map { |row| row[5...10] }
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
        nil
      end

      def finger_by_index(index)
        return if index.nil?
        index = 9 - index if index > 4
        %i(little ring middle index index)[index]
      end
    end
  end
end
