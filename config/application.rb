require File.expand_path('../boot', __FILE__)

require 'rails/all'

# https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-rails#activesupport-instrumentation
require 'elasticsearch/rails/instrumentation'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Transbucket
  class Application < Rails::Application
    # TODO include blocking ips for bad users
    # config.middleware.use Rack::Attack

    config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/page_cache"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.active_record.whitelist_attributes = false

    config.active_record.raise_in_transactional_callbacks = true

    # necessary for using bower-rails!
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'jquery-ui', 'themes', 'smoothness', 'images')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'tinymce', 'skins', 'lightgray', 'img')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'tinymce', 'skins', 'lightgray', 'fonts')

    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => false,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
    end
  end
end
