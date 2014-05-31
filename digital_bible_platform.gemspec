# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'digital_bible_platform/version'

Gem::Specification.new do |spec|
  spec.name          = "digital_bible_platform"
  spec.version       = DigitalBiblePlatform::VERSION
  spec.authors       = ["Chip Miller"]
  spec.email         = ["charlespmiller@gmail.com"]
  spec.summary       = %q{A Ruby client for http://www.digitalbibleplatform.com/}
  spec.description   = %q{A Ruby client for http://www.digitalbibleplatform.com/}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "iso-639", '~> 0.2.4'
  spec.add_runtime_dependency 'typhoeus', '~> 0.6.8'
  spec.add_runtime_dependency 'oj'
  spec.add_runtime_dependency 'hashie'
  
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end