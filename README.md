# Algolia Jekyll Plugin 

[![Gem Version][1]](http://badge.fury.io/rb/algoliasearch-jekyll)
[![Build Status][2]](https://travis-ci.org/algolia/algoliasearch-jekyll)
[![Coverage Status][3]](https://coveralls.io/github/algolia/algoliasearch-jekyll?branch=master)
[![Code Climate][4]](https://codeclimate.com/github/algolia/algoliasearch-jekyll)
![Jekyll >= 2.5](https://img.shields.io/badge/jekyll-%3E%3D%202.5-green.svg)

Jekyll plugin to automatically index your Jekyll posts and pages into an
Algolia index by running `bundle exec jekyll algolia push`.

## Usage

```shell
$ bundle exec jekyll algolia push
```

This will push the content of your jekyll website to your Algolia index.

## Installation

The plugins requires only minimal configuration to setup, but be sure to
carefully follow all the steps involved.

### 1. Installing the gem

Add the `algoliasearch-jekyll` gem to your `Gemfile`, in the
`:jekyll_plugins` section. 

If you do not yet have a `Gemfile`, here is the minimal content to get you
started.

```ruby
source 'https://rubygems.org'

gem 'jekyll', '~> 2.5.3'

group :jekyll_plugins do
  gem 'algoliasearch-jekyll', '~> 0.7.0'
end
```

Run `bundle install` to download and install the gem on your system.

### 2. Loading the gem into Jekyll

Open `_config.yml` and add the gem to the list of gems loaded by Jekyll. To do
so, add `algoliasearch-jekyll` under the `gems` section:

```yaml
gems:
  - algoliasearch-jekyll
```

At that point, you can try to run `bundle exec jekyll help` to make sure
everything is correctly installed. If you see an help message for the `algolia`
command, you're good to go.

### 3. Configuring your Algolia account

Open the `_config.yml` again, and add the following `algolia` section:

```yaml
algolia:
  application_id: 'your_application_id'
  index_name:     'your_index_name'
```

You can find your *real* application id in your Algolia dashboard. If you do not
yet have an Algolia account, go create one, I'll wait for you here.

For security, your write API key will be read from the `ALGOLIA_API_KEY`
environment variable. 
Note that your API key should have write access to both the `index_name` and
`_tmp` suffixed version of it (eg. `your_index_name` and `your_index_name_tmp`)
in the previous example). This is due to the way we do atomic pushes by pushing
to a temporary index and then renaming it.

You can also store your write api key in a file named `_algolia_api_key`, in
your source directory. If you do this we __very, very, very strongly__ encourage
you to make sure the file is not tracked in your versioning system.

### 4. Running the indexing script

At this stage, you should be able to run the plugin to index your content to
your Algolia account. 

`ALGOLIA_API_KEY='your_write_api_key' bundle exec jekyll algolia push`.

### 5. Adding the dropdown

TODO


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
