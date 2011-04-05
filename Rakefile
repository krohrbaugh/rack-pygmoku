require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
require './lib/rack/pygmoku/version.rb'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "rack-pygmoku"
  gem.homepage = "http://github.com/krohrbaugh/rack-pygmoku"
  gem.license = "MIT"
  gem.summary = "Rack middleware for Pygments-based syntax highlighting"
  gem.description = %Q{Rack middleware for Pygments use in environments you cannot install Pygments directly (e.g., Heroku).}
  gem.email = "kevin@rohrbaugh.us"
  gem.authors = ["Kevin Rohrbaugh"]
  gem.version = Rack::Pygmoku::Version::STRING
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'nokogiri', '~> 1.4'
  gem.add_runtime_dependency 'pygments.rb', '~> 0'
  gem.add_development_dependency 'rspec', '~> 2.5.0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rack-pygmoku #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
