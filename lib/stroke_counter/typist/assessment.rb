module StrokeCounter::Typist::Assessment
  def path_to_file
    File.join 'lib', 'stroke_counter', 'texts', 'constitution_of_japan.txt'
  end

  def text_file
    File.new(path_to_file, "r")
  end

  def assess
    text_file.each_line do |line|
      type_language(line)
    end
    result
  end
end
