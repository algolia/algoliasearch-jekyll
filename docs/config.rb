###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration
config[:boilerplate_version] = '1.0.2'

config[:product_author] = '@Algolia'
config[:product_name] = 'Algolia for Jekyll'
config[:product_shortname] = 'Jekyll'
config[:product_description] = 'Add search to your static Jekyll website with Algolia'
config[:product_url] = 'https://community.algolia.com/jekyll/'
config[:product_repo] = 'https://github.com/algolia/algoliasearch-jekyll'
config[:product_utm] = 'jekyll_website'

# Jekyll-plugin specific values
require_relative '../lib/version'
config[:plugin_version] = AlgoliaSearchJekyllVersion.to_s
config[:plugin_rubygems_url] = "https://rubygems.org/gems/algoliasearch-jekyll/versions/#{config[:plugin_version]}"

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

helpers do
  def nav_active(path)
    current_page.path == path ? { class: 'l-header--menu-item__active' } : {}
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
