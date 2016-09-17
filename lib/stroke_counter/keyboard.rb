module StrokeCounter
  class Keyboard
    DEFAULT = :qwerty

    attr_reader :name
    def initialize(args = {} )
      @name = if args[:name].nil? || args[:name].empty?
                DEFAULT
              else
                args[:name].downcase.to_sym
              end
    end
  end
end
