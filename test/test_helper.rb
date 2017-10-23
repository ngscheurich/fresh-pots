require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "capybara/poltergeist"

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
