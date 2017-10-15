require 'algoliasearch'
require 'nokogiri'
require 'json'
require_relative './version'
require_relative './record_extractor'
require_relative './credential_checker'
require_relative './error_handler'

# `jekyll algolia push` command
class AlgoliaSearchJekyllPush < Jekyll::Command
  class << self
    attr_accessor :options, :config

    def init_with_program(_prog)
    end

    # Init the command with options passed on the command line
    # `jekyll algolia push ARG1 ARG2 --OPTION_NAME1 OPTION_VALUE1`
    # config comes from _config.yml
    def init_options(args = [], options = {}, config = {})
      args = [] unless args
      @args = args
      @options = options
      @config = config
      @is_verbose = @config['verbose']
      @is_dry_run = @config['dry_run']

      self
    end

    # Check if the specified file should be indexed (we exclude static files,
    # robots.txt and custom defined exclusions).
    def indexable?(file)
      return false if file.is_a?(Jekyll::StaticFile)

      basename = File.basename(file.path)
      extname = File.extname(basename)[1..-1]

      # Keep only markdown and html files
      allowed_extensions = %w(html)
      if @config['markdown_ext']
        allowed_extensions += @config['markdown_ext'].split(',')
      end
      if @config['algolia']
        allowed_extensions += (@config['algolia']['allowed_extensions'] || [])
      end
      return false unless allowed_extensions.include?(extname)

      return false if excluded_file?(file)

      true
    end

    # Check if the file is in the list of excluded files
    def excluded_file?(file)
      excluded = [
        %r{^page([0-9]*)/index\.html}
      ]
      if @config['algolia']
        excluded += (@config['algolia']['excluded_files'] || [])
      end

      # Exclude files explicitly excluded in _config
      excluded.each do |pattern|
        pattern = /#{Regexp.quote(pattern)}/ if pattern.is_a? String
        return true if file.path =~ pattern
      end

      # Call user custom exclude hook on remaining files
      return true if custom_hook_excluded_file?(file)

      false
    end

    # User custom method to exclude some files when algolia.excluded_files is
    # not enough
    def custom_hook_excluded_file?(_file)
      false
    end

    # Return a patched version of a Jekyll instance
    def jekyll_new(config)
      site = Jekyll::Site.new(config)

      # Patched version of `write` that will push to Algolia instead of writing
      # on disk
      def site.write
        items = []
        is_verbose = config['verbose']
        each_site_file do |file|
          next unless AlgoliaSearchJekyllPush.indexable?(file)
          Jekyll.logger.info "Extracting data from #{file.path}" if is_verbose
          new_items = AlgoliaSearchRecordExtractor.new(file).extract
          next if new_items.nil?
          ap new_items if is_verbose

          items += new_items
        end
        AlgoliaSearchJekyllPush.push(items)
      end

      site
    end

    # Get index settings
    def configure_index(index)
      settings = {
        distinct: true,
        attributeForDistinct: 'url',
        attributesForFaceting: %w(tags type title),
        attributesToIndex: %w(
          title h1 h2 h3 h4 h5 h6
          unordered(text)
          unordered(tags)
        ),
        attributesToRetrieve: nil,
        customRanking: [
          'desc(posted_at)',
          'desc(weight.tag_name)',
          'asc(weight.position)'
        ],
        highlightPreTag: '<span class="algolia__result-highlight">',
        highlightPostTag: '</span>'
      }

      # Merge default settings with user custom ones
      if @config['algolia']
        (@config['algolia']['settings'] || []).each do |key, value|
          settings[key.to_sym] = value
        end
      end

      begin
        index.set_settings(settings)
      rescue StandardError => error
        display_error(error)
        exit 1
      end
    end

    # Display the error in a human-friendly way if possible
    def display_error(error)
      error_handler = AlgoliaSearchErrorHandler.new
      readable_error = error_handler.readable_algolia_error(error.message)

      if readable_error
        error_handler.display(readable_error)
      else
        Jekyll.logger.error 'Algolia Error: HTTP Error'
        Jekyll.logger.warn error.message
      end
    end

    # Change the User-Agent header to isolate calls from this plugin
    def set_user_agent_header
      version = AlgoliaSearchJekyllVersion.to_s
      Algolia.set_extra_header('User-Agent', "Algolia for Jekyll #{version}")
    end

    # Create an index to push our data
    def create_index(index_name)
      set_user_agent_header
      index = Algolia::Index.new(index_name)
      configure_index(index) unless @is_dry_run
      index
    end

    # Push records to the index
    def batch_add_items(items, index)
      items.each_slice(1000) do |batch|
        Jekyll.logger.info "Indexing #{batch.size} items"
        begin
          index.add_objects!(batch) unless @is_dry_run
        rescue StandardError => error
          display_error(error)
          exit 1
        end
      end
    end

    def push(items)
      checker = AlgoliaSearchCredentialChecker.new(@config)
      checker.assert_valid

      Jekyll.logger.info '=== DRY RUN ===' if @is_dry_run

      # Add items to a temp index, then rename it
      index_name = checker.index_name
      index_name_tmp = "#{index_name}_tmp"
      batch_add_items(items, create_index(index_name_tmp))
      Algolia.move_index(index_name_tmp, index_name) unless @is_dry_run

      Jekyll.logger.info "Indexing of #{items.size} items " \
                         "in #{index_name} done."
    end
  end
end
