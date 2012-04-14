# -*- encoding: utf-8 -*-
require './lib/rack/pygmoku/version.rb'

Gem::Specification.new do |s|
  s.name        = 'rack-pygmoku'
  s.version     = Rack::Pygmoku::Version::STRING
  s.platform    = Gem::Platform::RUBY

  s.required_rubygems_version = Gem::Requirement.new(">= 1.5.0") if s.respond_to? :required_rubygems_version=
  s.authors     = ["Kevin Rohrbaugh"]
  s.email       = 'kevin@rohrbaugh.us'
  
  s.date        = '2012-04-13'
  s.homepage    = 'http://github.com/krohrbaugh/rack-pygmoku'
  s.licenses    = ["MIT"]

  s.summary     = 'Rack middleware for Pygments-based syntax highlighting'
  s.description = <<-EOF
Rack middleware for Pygments use in environments you cannot install Pygments
directly (e.g., Heroku).
EOF

  s.require_paths     = ["lib"]
  s.rubygems_version  = '1.8.0'
  
  s.files = [
    ".document",
    "CHANGELOG",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "lib/rack/pygmoku.rb",
    "lib/rack/pygmoku/version.rb",
    "spec/lib/rack/pygmoku/version_spec.rb",
    "spec/lib/rack/pygmoku_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/html_helper.rb"
  ]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.test_files = [
    "spec/lib/rack/pygmoku/version_spec.rb",
    "spec/lib/rack/pygmoku_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/html_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency('nokogiri',    ["~> 1.5.0"])
      s.add_runtime_dependency('pygments.rb', ["~> 0.2.0"])
      s.add_runtime_dependency('rack',        [">= 0"])

      # Dev dependencies
      s.add_development_dependency('bundler', ["~> 1.1.0"])
      s.add_development_dependency('rake',    ["~> 0.9.0"])
      s.add_development_dependency('rdoc',    ["~> 3.12"])
      s.add_development_dependency('rspec',   ["~> 2.9.0"])
      s.add_development_dependency('watchr',  ["~> 0.7"])
    else
      s.add_dependency('nokogiri',            ["~> 1.5.0"])
      s.add_dependency('pygments.rb',         ["~> 0.2.0"])
      s.add_dependency('rack',                [">= 0"])

      # Dev dependencies
      s.add_dependency('bundler',             ["~> 1.1.0"])
      s.add_dependency('rake',                ["~> 0.9.0"])
      s.add_dependency('rdoc',                ["~> 3.12"])
      s.add_dependency('rspec',               ["~> 2.9.0"])
      s.add_dependency('watchr',              ["~> 0.7"])
    end
  else
    s.add_dependency('nokogiri',              ["~> 1.5.0"])
    s.add_dependency('pygments.rb',           ["~> 0.2.0"])
    s.add_dependency('rack',                  [">= 0"])

    # Dev dependencies
    s.add_dependency('bundler',               ["~> 1.1.0"])
    s.add_dependency('rake',                  ["~> 0.9.0"])
    s.add_dependency('rdoc',                  ["~> 3.12"])
    s.add_dependency('rspec',                 ["~> 2.9.0"])
    s.add_dependency('watchr',                ["~> 0.7"])
  end
end

