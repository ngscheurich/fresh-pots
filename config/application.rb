require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module FreshPots
  class Application < Rails::Application
    config.action_controller.action_on_unpermitted_parameters = :raise

    config.fresh_pots = config_for(:fresh_pots)
    config.fresh_pots["max_brew_hours"] ||= "5"

    config.time_zone = "America/Chicago"

    config.load_defaults 5.1
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :rspec
    end

    def after_sign_out_path_for(resource_or_scope)
      login_url
    end

    def authenticate_user!
      if user_signed_in?
        super
      else
        redirect_to login_url, notice: "You must be logged in to access that!"
      end
    end
  end
end
