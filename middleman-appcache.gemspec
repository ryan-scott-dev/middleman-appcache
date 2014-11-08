# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-appcache/version"

Gem::Specification.new do |s|
  s.name        = "middleman-appcache"
  s.version     = Middleman::AppCache::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ryan Scott']
  s.email       = ['atthealma@gmail.com']

  s.homepage    = "https://github.com/Archytaus/middleman-appcache"
  s.summary     = %q{Generate appcache manifest for your Middleman Project}
  s.description = %q{Generate appcache manifest for your Middleman Project}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  
  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.3.6"])
end
