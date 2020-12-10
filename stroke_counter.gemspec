lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stroke_counter/version'

Gem::Specification.new do |spec|
  spec.name          = 'stroke_counter'
  spec.version       = StrokeCounter::VERSION
  spec.authors       = ['Shimpei Otsubo']
  spec.email         = ['potsbo@gmail.com']

  spec.summary       = 'Keyboard stroke counter for each key to evaluate a certain keyboard layout.'
  spec.description   = 'Keyboard stroke counter for each key to evaluate a certain keyboard layout.'
  spec.homepage      = 'https://github.com/potsbo/stroke_counter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'anpan'
  spec.add_dependency 'natto'
end
