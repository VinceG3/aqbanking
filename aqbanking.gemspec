# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aqbanking/version'

Gem::Specification.new do |spec|
  spec.name          = "aqbanking"
  spec.version       = Aqbanking::VERSION
  spec.authors       = ["Vincent Guidry"]
  spec.email         = ["vguidry@gmail.com"]
  spec.summary       = %q{a simple wrapper around aqbanking-cli}
  spec.description   = %q{a simple wrapper around aqbanking-cli}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
