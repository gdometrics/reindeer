require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EdnaConsole
  class Application < Rails::Application
    require "#{Rails.root.to_s}/lib/settings"

    # Raise transaction errors
    config.active_record.raise_in_transactional_callbacks = true

    # Use router as the exception app
    # http://easyactiverecord.com/blog/2014/08/19/redirecting-to-custom-404-and-500-pages-in-rails/
    config.exceptions_app = self.routes

    #How to silence "I18n.enforce_available_locales" deprecation warnings
    config.i18n.enforce_available_locales = false
    config.action_controller.relative_url_root  = ENV['RAILS_RELATIVE_URL_ROOT']
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Search the models directory recursively
    #config.autoload_paths += Dir["#{Rails.root.to_s}/app/models/**/*.rb"] 
    config.autoload_paths += Dir["#{Rails.root.to_s}/app/controllers/**/*.rb"] 
    config.autoload_paths += Dir["#{Rails.root.to_s}/app/lib/**/*.rb"] 

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.4'
    
    # Setup automatic code generator configuration
    # E.g. $ rails g model WhipperSnapper
    config.generators do |g|
      g.test_framework :minitest, spec: true, fixture: false
      g.integration_tool :mini_test
    end

  end
end