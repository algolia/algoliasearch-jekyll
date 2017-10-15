# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: algoliasearch-jekyll 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "algoliasearch-jekyll".freeze
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tim Carry".freeze]
  s.date = "2017-10-15"
  s.description = "Index all your pages and posts to an Algolia index with `jekyll algolia push`".freeze
  s.email = "tim@pixelastic.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".coveralls.yml",
    ".rspec",
    ".rubocop.yml",
    ".travis.yml",
    "Appraisals",
    "CONTRIBUTING.md",
    "Gemfile",
    "Guardfile_jekyllv2",
    "Guardfile_jekyllv3",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "algoliasearch-jekyll.gemspec",
    "docs/travis-settings.png",
    "gemfiles/jekyll_v2.gemfile",
    "gemfiles/jekyll_v3.gemfile",
    "lib/algoliasearch-jekyll.rb",
    "lib/credential_checker.rb",
    "lib/error_handler.rb",
    "lib/push.rb",
    "lib/record_extractor.rb",
    "lib/version.rb",
    "scripts/bump_version",
    "scripts/check_flay",
    "scripts/check_flog",
    "scripts/coverage",
    "scripts/git_hooks/pre-commit",
    "scripts/git_hooks/pre-push",
    "scripts/lint",
    "scripts/release",
    "scripts/test",
    "scripts/test_ci",
    "scripts/test_v2",
    "scripts/test_v3",
    "scripts/watch",
    "scripts/watch_v2",
    "scripts/watch_v3",
    "spec/credential_checker_spec.rb",
    "spec/error_handler_spec.rb",
    "spec/fixtures/jekyll_version_2/_config.yml",
    "spec/fixtures/jekyll_version_2/_layouts/default.html",
    "spec/fixtures/jekyll_version_2/_my-collection/collection-item.html",
    "spec/fixtures/jekyll_version_2/_my-collection/collection-item.md",
    "spec/fixtures/jekyll_version_2/_posts/2015-07-02-test-post.md",
    "spec/fixtures/jekyll_version_2/_posts/2015-07-03-test-post-again.md",
    "spec/fixtures/jekyll_version_2/about.md",
    "spec/fixtures/jekyll_version_2/api_key_dir/_algolia_api_key",
    "spec/fixtures/jekyll_version_2/assets/ring.png",
    "spec/fixtures/jekyll_version_2/authors.html",
    "spec/fixtures/jekyll_version_2/excluded.html",
    "spec/fixtures/jekyll_version_2/hierarchy.md",
    "spec/fixtures/jekyll_version_2/index.html",
    "spec/fixtures/jekyll_version_2/page2/index.html",
    "spec/fixtures/jekyll_version_2/weight.md",
    "spec/fixtures/jekyll_version_3/_config.yml",
    "spec/fixtures/jekyll_version_3/_layouts/default.html",
    "spec/fixtures/jekyll_version_3/_my-collection/collection-item.html",
    "spec/fixtures/jekyll_version_3/_my-collection/collection-item.md",
    "spec/fixtures/jekyll_version_3/_posts/2015-07-02-test-post.md",
    "spec/fixtures/jekyll_version_3/_posts/2015-07-03-test-post-again.md",
    "spec/fixtures/jekyll_version_3/about.md",
    "spec/fixtures/jekyll_version_3/api_key_dir/_algolia_api_key",
    "spec/fixtures/jekyll_version_3/assets/ring.png",
    "spec/fixtures/jekyll_version_3/authors.html",
    "spec/fixtures/jekyll_version_3/excluded.html",
    "spec/fixtures/jekyll_version_3/hierarchy.md",
    "spec/fixtures/jekyll_version_3/index.html",
    "spec/fixtures/jekyll_version_3/page2/index.html",
    "spec/fixtures/jekyll_version_3/weight.md",
    "spec/push_spec.rb",
    "spec/record_extractor_spec.rb",
    "spec/spec_helper.rb",
    "spec/spec_helper_simplecov.rb",
    "txt/api_key_missing",
    "txt/application_id_missing",
    "txt/check_key_acl_to_tmp_index",
    "txt/index_name_missing",
    "txt/sample"
  ]
  s.homepage = "https://github.com/algolia/algoliasearch-jekyll".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "AlgoliaSearch for Jekyll".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<algoliasearch>.freeze, ["~> 1.12"])
      s.add_runtime_dependency(%q<appraisal>.freeze, ["~> 2.1.0"])
      s.add_runtime_dependency(%q<awesome_print>.freeze, ["~> 1.6"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 1.8.6"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.7.2", "~> 1.7"])
      s.add_runtime_dependency(%q<verbal_expressions>.freeze, ["~> 0.1.5"])
      s.add_development_dependency(%q<rake>.freeze, ["< 11.0"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8"])
      s.add_development_dependency(%q<flay>.freeze, ["~> 2.6"])
      s.add_development_dependency(%q<flog>.freeze, ["~> 4.3"])
      s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4.6"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.31"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.10"])
      s.add_development_dependency(%q<rack>.freeze, ["< 2"])
    else
      s.add_dependency(%q<algoliasearch>.freeze, ["~> 1.12"])
      s.add_dependency(%q<appraisal>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<awesome_print>.freeze, ["~> 1.6"])
      s.add_dependency(%q<json>.freeze, [">= 1.8.6"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.7.2", "~> 1.7"])
      s.add_dependency(%q<verbal_expressions>.freeze, ["~> 0.1.5"])
      s.add_dependency(%q<rake>.freeze, ["< 11.0"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.8"])
      s.add_dependency(%q<flay>.freeze, ["~> 2.6"])
      s.add_dependency(%q<flog>.freeze, ["~> 4.3"])
      s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.6"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.31"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.10"])
      s.add_dependency(%q<rack>.freeze, ["< 2"])
    end
  else
    s.add_dependency(%q<algoliasearch>.freeze, ["~> 1.12"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<awesome_print>.freeze, ["~> 1.6"])
    s.add_dependency(%q<json>.freeze, [">= 1.8.6"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.7.2", "~> 1.7"])
    s.add_dependency(%q<verbal_expressions>.freeze, ["~> 0.1.5"])
    s.add_dependency(%q<rake>.freeze, ["< 11.0"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8"])
    s.add_dependency(%q<flay>.freeze, ["~> 2.6"])
    s.add_dependency(%q<flog>.freeze, ["~> 4.3"])
    s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.6"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.31"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.10"])
    s.add_dependency(%q<rack>.freeze, ["< 2"])
  end
end

