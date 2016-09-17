module StrokeCounter
  class Keyboard
    DEFAULT = :qwerty

    attr_reader :name
    def initialize(args = {} )
      @name = args[:name] || DEFAULT
    end
  end
end
