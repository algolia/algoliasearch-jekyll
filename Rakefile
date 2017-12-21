require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

require 'jeweler'
require_relative 'lib/version'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see
  # http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'algoliasearch-jekyll'
  gem.version = AlgoliaSearchJekyllVersion.to_s
  gem.homepage = 'https://github.com/algolia/algoliasearch-jekyll'
  gem.license = 'MIT'
  gem.summary = '[⚠ DEPRECATED ⚠]: Use jekyll-algolia instead'.freeze
  gem.description = '[⚠ DEPRECATED ⚠]: Use jekyll-algolia instead'.freeze
  gem.email = 'tim@pixelastic.com'
  gem.authors = ['Tim Carry']
  gem.post_install_message = <<-MESSAGE
  !    The 'algolisearch-jekyll' gem has been deprecated and has been replaced with 'jekyll-algolia'.
  !    See: https://rubygems.org/gems/jekyll-algolia
  !    And: https://github.com/algolia/jekyll-algolia
  !
  !    You can get quickly started on the new plugin using this documentation:
  !    https://community.algolia.com/jekyll-algolia/getting-started.html
  MESSAGE

  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = '--color --format documentation'
  spec.pattern = FileList['spec/**/*_spec.rb']
end
task test: :spec

desc 'Code coverage detail'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['spec'].execute
end

task default: :test
