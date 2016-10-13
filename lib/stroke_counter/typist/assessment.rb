module StrokeCounter
  class Typist
    module Assessment
      FILENAMES = {
        en: 'constitution_of_the_united_states.txt',
        ja: 'constitution_of_japan.txt',
      }
      def path_to_file(filename = nil)
        filename ||= 'constitution_of_japan.txt'
        File.join 'lib', 'stroke_counter', 'texts', filename
      end

      def text_file(filename: nil)
        File.new(path_to_file(filename), 'r')
      end

      def assess(filename: nil, lang: nil)
        filename = FILENAMES[lang.to_sym] if lang
        text_file(filename: filename).each_line do |line|
          type_language(line)
        end
        result
      end
    end
  end
end
