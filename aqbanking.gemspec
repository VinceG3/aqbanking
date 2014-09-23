# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aqbanking/version'

Gem::Specification.new do |spec|
  spec.name          = "aqbanking"
  spec.version       = Aqbanking::VERSION
  spec.authors       = ["Vincent Guidry"]
  spec.email         = ["vguidry@gmail.com"]
  spec.summary       = %q{A thin wrapper over the aqbanking-cli utility}
  spec.description   = %q{This gem very thinly wraps the aqbanking-cli utility, allowing you to download transactions non-interactively. That utility should be installed and configured before using this gem.}
  spec.homepage      = "https://github.com/VinceG3/aqbanking"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "dotenv"
  spec.add_dependency "activesupport"
end
