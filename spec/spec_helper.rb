$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "stroke_counter"

require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov
