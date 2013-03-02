module ZagirovName
  class Application < Rails::Application
    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0.2'

    config.assets.precompile += %w(main.js main.css sessions.js sessions.css)
    config.assets.precompile += %w(admin.js admin.css)
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  end
end