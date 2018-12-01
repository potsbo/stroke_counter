$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'stroke_counter'

require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov
