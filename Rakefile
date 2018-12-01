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

  puts "#{layouts.size} layouts found: #{layouts}"
  puts "#{languages.size} languages found: #{languages}"
  puts "#{tables.size} tables found: #{tables}"

  size = languages.size * languages.size * tables.size

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
  File.open('result.json', 'w') do |f|
    f.write(JSON.pretty_generate(results: results.flatten, metadata: {}))
  end
  puts 'result has been written to result.json'
end
