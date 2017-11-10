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
    config.load_defaults 5.1
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :rspec
    end
  end
end
