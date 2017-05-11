require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'stroke_counter'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :assess do
  puts StrokeCounter::Typist.new.assess
end
