require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rack/pygmoku/version'

def pkg_dir; @pkg_dir ||= File.expand_path('../pkg', __FILE__); end
def gem_name;           'rack-pygmoku'; end
def gemspec_file_name;  "#{gem_name}.gemspec"; end
def gem_file_name;      "#{gem_name}-#{Rack::Pygmoku::Version::STRING}.gem"; end

desc "Build gem"
task :build do
  system "gem build #{gemspec_file_name}"

  FileUtils.mkdir_p(pkg_dir) unless Dir.exist?(pkg_dir)
  FileUtils.mv gem_file_name, pkg_dir
end

desc "Release gem"
task :release => :build do
  system "gem push #{File.join(pkg_dir, gem_file_name)}"
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.main = 'README.markdown'
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

desc "Run watchr (auto-test)"
task :watchr do
  sh %{bundle exec watchr watchr.rb}
end
