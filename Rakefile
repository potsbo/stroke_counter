require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'stroke_counter'
require 'json'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :assess do
  languages = StrokeCounter::Typist::Assessment.languages
  layouts   = StrokeCounter::Keyboard::Layout::PRESETS.keys
  tables    = StrokeCounter::Typist::Brain::ROMAJI_TABLES.keys

  typists = layouts.map do |k|
    tables.map do |b|
      StrokeCounter::Typist.new(keyboard: k, brain: b)
    end
  end.flatten

  puts 'Typists loaded'
  puts "#{layouts.size} layouts found: #{layouts}"
  puts "#{languages.size} languages found: #{languages}"
  puts "#{tables.size} tables found: #{tables}"
  puts

  size = languages.size * typists.size

  cnt = 0
  results = []
  languages.each do |lang|
    puts "Assessment: #{lang}"
    layouts.each do |k|
      tables.each do |t|
        cnt += 1
        typist = StrokeCounter::Typist.new(keyboard: k, brain: t)
        puts "#{cnt}/#{size}: #{k}, #{t} started"
        results << { setting: typist.setting.merge(lang: lang), result: typist.assess(lang: lang) }
        puts "#{cnt}/#{size}: #{k}, #{t} finished"
      end
    end
  end
  output = { results: results.flatten, metadata: {} }
  File.open('result.json', 'w') do |f|
    f.write(JSON.pretty_generate(output))
  end
  puts 'result has been written to result.json'
end
