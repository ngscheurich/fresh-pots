require "spec_helper"

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require "rspec/rails"
require "capybara/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

module Features
  include Formulaic::Dsl
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Features, type: :feature
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.extend ControllerMacros, type: :controller
end
