require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'stroke_counter'
require 'json'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :assess do
  languages = StrokeCounter::Typist::Assessment.languages
  typists = StrokeCounter::Typist.all
  size = languages.size * typists.size

  cnt = 0
  results = []
  languages.each do |lang|
    typists.each do |t|
      cnt += 1
      puts "#{cnt}/#{size}"
      results << { setting: t.setting.merge(lang: lang), result: t.assess(lang: lang) }
    end
  end
  output = { results: results.flatten, metadata: {} }
  File.open('result.json', 'w') do |f|
    f.write(JSON.pretty_generate(output))
  end
end
