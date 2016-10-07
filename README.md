# StrokeCounter

[![Build Status](https://travis-ci.org/potsbo/stroke_counter.svg?branch=master)](https://travis-ci.org/potsbo/stroke_counter)
[![Code Climate](https://codeclimate.com/github/potsbo/stroke_counter/badges/gpa.svg)](https://codeclimate.com/github/potsbo/stroke_counter)
[![codecov](https://codecov.io/gh/potsbo/stroke_counter/branch/master/graph/badge.svg)](https://codecov.io/gh/potsbo/stroke_counter)


StrokeCounter can count and analyze keyboard strokes.
It is useful to have quantitative evaluation for a keyboard layout.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stroke_counter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stroke_counter

## Usage

You can simply assess a keyboard layout with following code.
```ruby
StrokeCounter::Typist.new(mode: :dvorak).assess
````

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/potsbo/stroke_counter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

