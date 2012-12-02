# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'happy_api/version'

Gem::Specification.new do |gem|
  gem.name          = "happy_api"
  gem.version       = HappyApi::VERSION
  gem.authors       = ["Elad Meidar"]
  gem.email         = ["elad@eizesus.com"]
  gem.description   = %q{HappyApi (Joy Joy) is a RESTful based ORM}
  gem.summary       = %q{HappyApi enables the use of extranal services as RESTful access points.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib", "lib/happy_api"]

  gem.add_dependency "typhoeus"
  gem.add_dependency "faraday"
  gem.add_dependency "system_timer"
  gem.add_dependency "activesupport"
  gem.add_dependency "yajl-ruby"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "fakeweb"
end
