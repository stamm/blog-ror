require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module ZagirovName
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/lib)
    config.time_zone = 'Moscow'

    config.i18n.default_locale = :ru

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true
    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0.3'

    config.assets.precompile += %w(main.js main.css sessions.js sessions.css
      static_pages.js static_pages.css
      admin.js admin.css
      *.png *.jpg *.jpeg *.gif)

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
