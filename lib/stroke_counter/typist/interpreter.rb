require 'natto'

module StrokeCounter
  class Typist
    class Brain
      module Interpreter
        def to_katakana(input)
          nm = Natto::MeCab.new
          words = []
          nm.parse(input) do |n|
            feature = n.feature.split(',')
            words << feature[7] unless feature[0] == 'BOS/EOS'
          end
          words.join
        end

        def to_hiragana(input)
          input.tr('ァ-ン','ぁ-ん')
        end
      end
    end
  end
end
