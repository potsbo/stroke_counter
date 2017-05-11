require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'stroke_counter'
require 'json'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :assess do
  results = StrokeCounter::Typist.all.map{|t| t.setting}
  output = { results: results, metadata: {} }
  puts JSON.pretty_generate(results)
end
