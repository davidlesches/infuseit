# encoding: utf-8
require File.expand_path('../lib/infuseit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name                      = 'infuseit'
  gem.summary                   = %q{Ruby wrapper for the Infusionsoft API}
  gem.description               = 'A Ruby wrapper for the Infusionsoft API'
  gem.authors                   = ["David Lesches", "Nathan Levitt"]
  gem.email                     = ['david@lesches.com']
  gem.executables               = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files                     = `git ls-files`.split("\n")
  gem.homepage                  = 'https://github.com/davidlesches/infuseit'
  gem.require_paths             = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')

  gem.add_development_dependency 'rake'

  gem.version = Infuseit::VERSION
end

