# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google/scholar/version'
require 'rbconfig'
Gem::Specification.new do |spec|
  spec.name          = "google-scholar-rb"
  spec.version       = Google::Scholar::VERSION
  spec.authors       = ["Trey Terrell"]
  spec.email         = ["trey.terrell@oregonstate.edu"]
  spec.description   = %q{Google Scholar interface. Currently only works for Author searches.}
  spec.summary       = %q{Google Scholar interface. Currently only works for Author searches.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', '~> 1.5.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.13'
  spec.add_development_dependency 'guard', '~> 1.8.0'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'wdm', '>= 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i
end
