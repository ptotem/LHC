require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Lhc
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.assets.enabled=true
    config.assets.initialize_on_precompile = false
    config.assets.precompile += ['rails_admin/rails_admin.css','rails_admin/rails_admin.js']
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif,
                                  "fontawesome-webfont.ttf",
                                 "fontawesome-webfont.eot",
                                 "fontawesome-webfont.svg",
                                 "fontawesome-webfont.woff")

    config.assets.precompile << Proc.new do |path|
      if path =~ /\.(css|js)\z/
        full_path = Rails.application.assets.resolve(path).to_path
        app_assets_path = Rails.root.join('app', 'assets').to_path
        if full_path.starts_with? app_assets_path
          puts "including asset: " + full_path
          true
        else
          puts "excluding asset: " + full_path
          false
        end
      else
        false
      end
    end

    #config.action_mailer.default_url_options = {:host => "localhost:3000"}
    config.action_mailer.default_url_options = {:host => "www.letshavecoffee.in"}


    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.middleware.use Mobvious::Manager
  end
end
