require 'active_support'
require 'active_support/core_ext/object/blank'
require 'stroke_counter/keyboard/layout'

module StrokeCounter
  class Keyboard
    def initialize(args = {} )
      @layout = Layout.new(name: args[:name])
    end

    def name
      @layout.name
    end

    def has_key?(key, on: nil)
      case on
        when :left
          return @layout.left_side_keys.include?(key.to_sym)
        when :right
          return @layout.right_side_keys.include?(key.to_sym)
        when nil
          return @layout.keys.include?(key.to_sym)
        else
          return false
      end
    end

    def type_feedback(key)
      { hand: @layout.has_key_on(key), finger: @layout.finger_by_key(key) }
    end
  end
end
