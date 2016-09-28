module StrokeCounter::Typist::Assessment
  def path_to_file(filename = nil)
    filename ||= 'constitution_of_japan.txt'
    File.join 'lib', 'stroke_counter', 'texts', filename
  end

  def text_file(filename: nil)
    File.new(path_to_file(filename), "r")
  end

  def assess(filename: nil)
    text_file(filename: filename).each_line do |line|
      type_language(line)
    end
    result
  end
end
