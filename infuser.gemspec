# encoding: utf-8
require File.expand_path('../lib/infuser/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name                      = 'infuser'
  spec.summary                   = %q{Ruby wrapper for the Infusionsoft API}
  spec.description               = 'A Ruby wrapper for the Infusionsoft API'
  spec.authors                   = ["David Lesches"]
  spec.email                     = ['david@lesches.com']
  spec.executables               = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  spec.files                     = `git ls-files`.split("\n")
  spec.homepage                  = 'https://github.com/davidlesches/infuser'
  spec.require_paths             = ['lib']
  spec.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')

  spec.add_dependency 'activesupport'
  spec.add_dependency 'rest-client'
  spec.add_development_dependency 'rake'

  spec.version = Infuser::VERSION
end

