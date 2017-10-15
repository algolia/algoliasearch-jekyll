# Algolia Jekyll Plugin 

[![Gem Version][1]](http://badge.fury.io/rb/algoliasearch-jekyll)
[![Build Status][2]](https://travis-ci.org/algolia/algoliasearch-jekyll)
[![Coverage Status][3]](https://coveralls.io/github/algolia/algoliasearch-jekyll?branch=master)
[![Code Climate][4]](https://codeclimate.com/github/algolia/algoliasearch-jekyll)
![Jekyll >= 2.5](https://img.shields.io/badge/jekyll-%3E%3D%202.5-green.svg)

Jekyll plugin to automatically index your Jekyll posts and pages into an
Algolia index by simply running `jekyll algolia push`.

## Usage

```shell
$ bundle exec jekyll algolia push
```

This will push the content of your jekyll website to your Algolia index.

You can specify any option you would normally pass to `jekyll build`, like
`--config`, `--source`, `--destination`, etc.

## Installation

First, add the `algoliasearch-jekyll` gem to your `Gemfile`, in the
`:jekyll_plugins` section. If you do not yet have a `Gemfile`, here is the
minimum content to get your started.

```ruby
source 'https://rubygems.org'

gem 'jekyll', '~> 2.5.3'

group :jekyll_plugins do
  gem 'algoliasearch-jekyll', '~> 0.8.2'
end
```

Once this is done, download all dependencies with `bundle install`. 

Then, add `algoliasearch-jekyll` to your `_config.yml` file, under the `gems`
section, like this:

```yaml
plugins:
  - algoliasearch-jekyll
```

If everything went well, you should be able to execute `jekyll help` and see the
`algolia` subcommand listed.

## Configuration

Add information about your Algolia configuration into the `_config.yml` file,
under the `algolia` section, like this:

```yaml
algolia:
  application_id: 'your_application_id'
  index_name:     'your_index_name'
```

You can also define the `ALGOLIA_APPLICATION_ID` and `ALGOLIA_INDEX_NAME`
environment variables. If present, they will be used instead of the options in
`_config.yml`.

Your write api key will be read from the `ALGOLIA_API_KEY` environment variable.
You can define it on the same line as your command, allowing you to type
`ALGOLIA_API_KEY='your_write_api_key' jekyll algolia push`.

Note that your API key should have write access to both the `index_name` and
`_tmp` suffixed version of it (eg. `your_index_name` and `your_index_name_tmp`)
in the previous example). This is due to the way we do atomic pushes by pushing
to a temporary index and then renaming it. The easiest way is to create a key
with access to in the `index_name*` index (note the `*` suffix).

### ⚠ Other, unsecure, method ⚠

You can also store your write api key in a file named `_algolia_api_key`, in
your source directory. If you do this we __very, very, very strongly__ encourage
you to make sure the file is not tracked in your versioning system.

### Options

The plugin uses sensible defaults, but you may want to override some of its
configuration. Here are the various options you can add to your `_config.yml`
file, under the `algolia` section:

#### `excluded_files`

Defines which files should not be indexed for search.

```yml
algolia:
  excluded_files:
    - index.html
    - 2015-01-01-post.md
```

#### `record_css_selector`

Defines the css selector inside a page/post used to choose which parts to index.
It is set to all paragraphs (`<p>`) by default.

If you would like to also index lists, you could set it like this:

```yml
algolia:
  record_css_selector: 'p,ul'
```

#### `allowed_extensions`

Define additional extensions to be indexed. The default behaviour is to index
only markdown and HTML files.

```yml
algolia:
  allowed_extensions:
    - adoc
    - ad
```

#### `settings`

Here you can pass any specific [index settings][5] to your Algolia index. All
the settings supported by the API can be passed here.

##### Examples 

If you want to activate `distinct` and some snippets for example, you would do:

```yml
algolia:
  settings:
    attributeForDistinct: 'hierarchy'
    distinct: true
    attributesToSnippet: ['text:20']
```

If you want to search in other fields than the default ones, you'll have to edit
the `attributesToIndex` (default is `%w(title h1 h2 h3 h4 h5 h6 unordered(text)
unordered(tags))`

```yml
algolia:
  settings:
    attributesToIndex:
      - title
      - h1
      - h2
      - h3
      - h4
      - h5
      - h6
      - unordered(text)
      - unordered(tags)
      - your_custom_attribute_1
      - your_custom_attribute_2
      - ...
```

### Hooks

The `AlgoliaSearchRecordExtractor` contains two methods (`custom_hook_each` and
`custom_hook_all`) that are here so you can overwrite them to add your custom
logic. They currently simply return the argument they take as input.

The best way to override them is to create a `./_plugins/search.rb` file, with
the following content:

```ruby
class AlgoliaSearchRecordExtractor
  # Hook to modify a record after extracting
  def custom_hook_each(item, node)
    # `node` is a Nokogiri HTML node, so you can access its type through `node.name`
    # or its classname through `node.attr('class')` for example

    # Just return `nil` instead of `item` if you want to discard this record
    item
  end

  # Hook to modify all records after extracting
  def custom_hook_all(items)
    items
  end
end
```

The `AlgoliaSearchJekyllPush` class also lets user define the
`custom_hook_excluded_file?` method. This method is called on every file that
the plugin thinks it should parse and index. If it returns `true`, the file is
not indexed. You can add here your custom logic to exclude some files.

```ruby
class AlgoliaSearchJekyllPush < Jekyll::Command
  class << self
    # Hook to exclude some files from indexing
    def custom_hook_excluded_file?(file)
      return true if file.path =~ %r{^/excluded_dir/}
      false
    end
  end
end
```

## Command line

Here is the list of command line options you can pass to the `jekyll algolia
push` command:

| Flag                     | Description                                                           | 
| ----                     | -----                                                                 | 
| `--config ./_config.yml` | You can here specify the config file to use. Default is `_config.yml` | 
| `--future`               | With this flag, the command will also index posts with a future date  | 
| `--limit_posts 10`       | Limits the number of posts to parse and index                         | 
| `--drafts`               | Index drafts in the `_drafts` folder as well                          | 
| `--dry-run` or `-n`      | Do a dry run, do not actually push anything to your index             | 
| `--verbose`              | Display more information about what is going to be indexed            | 

## Dependencies

The `algoliasearch-jekyll` plugin works for versions of Jekyll starting from
2.5, with a version of Ruby of at least 2.0. You also need
[Bundler][6] to easily add the gem as a dependency to Jekyll.

## Searching

This plugin will only index your data in your Algolia index. Adding search
capabilities is quite easy. You can follow [our tutorials][7] or use our forked
version of the popular [Hyde theme][8].

## GitHub Pages

GitHub does not allow custom plugins to be run on GitHub Pages. This means that
you'll either have to run `bundle exec jekyll algolia push` manually, or
configure TravisCI to do it for you.

[Travis CI][9] is an hosted continuous integration
service, and it's free for open-source projects. Properly configured, it can
automatically reindex your data whenever you push to `gh-pages`.

For it to work, you'll have 3 steps to perform.

### 1. Create a `.travis.yml` file

Create a file named `.travis.yml` at the root of your project, with the
following content:

```yml
language: ruby
cache: bundler
branches:
  only:
    - gh-pages
script: 
  - bundle exec jekyll algolia push
rvm:
 - 2.2
```

This file will be read by Travis and instruct it to fetch all dependencies
defined in the `Gemfile`, then run `jekyll algolia push`. This will only be
triggered when data is pushed to the `gh-pages` branch.

### 2. Update your `_config.yml` file to exclude `vendor`

Travis will download all you `Gemfile` dependencies into a directory named
`vendor`. You have to tell Jekyll to ignore this directory, otherwise Jekyll
will try to parse it (and fail).

Doing so is easy, just add the following line to your `_config.yml` file:

```yml
exclude: [vendor]
```

### 3. Configure Travis

In order for Travis to be able to push data to your index on your behalf, you
have to give it your write API Key. This is achieved by defining an
`ALGOLIA_API_KEY` [environment variable][10] in Travis settings.

You should also uncheck the "Build pull requests" option, otherwise any pull
request targeting `gh-pages` will trigger the reindexing.

![Travis Configuration][11]

### Done

Commit all the changes to the files, and then push to `gh-pages`. Travis will
catch the event and trigger your indexing for you. You can follow the Travis job
execution directly on [their website][12].


[1]: https://badge.fury.io/rb/algoliasearch-jekyll.svg
[2]: https://travis-ci.org/algolia/algoliasearch-jekyll.svg?branch=master
[3]: https://coveralls.io/repos/algolia/algoliasearch-jekyll/badge.svg?branch=master&service=github
[4]: https://codeclimate.com/github/algolia/algoliasearch-jekyll/badges/gpa.svg
[5]: https://www.algolia.com/doc/ruby#indexing-parameters
[6]: http://bundler.io/
[7]: https://www.algolia.com/doc/javascript
[8]: https://github.com/algolia/hyde
[9]: https://travis-ci.org/
[10]: http://docs.travis-ci.com/user/environment-variables/
[11]: /docs/travis-settings.png
[12]: https://travis-ci.org
