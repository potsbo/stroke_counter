require 'active_support'
require 'active_support/core_ext/object/blank'
require 'stroke_counter/keyboard/layout'
require 'stroke_counter/keyboard/logger'

module StrokeCounter
  class Keyboard
    def initialize(args = {})
      @layout = Layout.new(name: args[:name])
    end

    def name
      @layout.name
    end

    def key?(key, on: nil)
      case on
      when :left
        @layout.left_side_keys.include?(key.to_sym)
      when :right
        @layout.right_side_keys.include?(key.to_sym)
      when nil
        @layout.key?(key.to_sym)
      else
        false
      end
    end

    def type_feedback(key)
      { hand: @layout.key_on(key), finger: @layout.finger_by_key(key), key: key, row: @layout.row_by_key(key) }
    end
  end
end
