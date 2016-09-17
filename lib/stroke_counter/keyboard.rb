require 'active_support'
require 'active_support/core_ext/object/blank'

module StrokeCounter
  class Keyboard
    DEFAULT = :qwerty

    attr_reader :name
    def initialize(args = {} )
      @name = ( args[:name].presence || DEFAULT ).downcase.to_sym
    end
  end
end
