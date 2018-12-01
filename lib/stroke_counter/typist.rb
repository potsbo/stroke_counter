require 'stroke_counter/typist/brain'
require 'stroke_counter/typist/interpreter'
require 'stroke_counter/typist/assessment'

module StrokeCounter
  class Typist
    VALID_MODE = %i(normal qwerty dvorak).freeze
    attr_reader :mode, :keyboard, :logger

    def initialize(args = {})
      @mode = args[:mode]
      @mode = :qwerty if @mode == :normal
      @mode = :qwerty unless VALID_MODE.include? @mode

      @logger   = StrokeCounter::Keyboard::Logger.new
      @keyboard = StrokeCounter::Keyboard.new(name: args[:keyboard] || @mode)
      @brain    = Brain.new(mode: args[:brain] || @mode)
    end

    def setting
      { keyboard: @keyboard.name, brain: @brain.mode }
    end

    include  Brain::Interpreter
    include  Assessment

    def type_language(input)
      hiragana = yomi(input)
      type_keys @brain.to_keys(hiragana)
    end

    def type_keys(str)
      str.each_char { |c| type_key(c.to_sym) }
      self
    end

    def type_key(char)
      @logger.add_log @keyboard.type_feedback(char)
      self
    end

    def log
      @logger.logs
    end

    def result
      @logger.analyze
    end
  end
end
