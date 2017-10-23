require "test_helper"

module Users
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    test "should allow any email when authorization is disabled" do
      Rails.configuration.email_authorization["enabled"] = false

      post user_registration_url, params: user_params("test@example.com")

      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_match(/confirm/i, flash[:notice])
    end

    test "should allow whitelisted email domains" do
      Rails.configuration.email_authorization["enabled"] = true
      Rails.configuration.email_authorization["domains"] = ["allowed.com"]

      post user_registration_url, params: user_params("test@allowed.com")

      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_match(/confirm/i, flash[:notice])
    end

    test "should disallow non-whitelisted email domains" do
      Rails.configuration.email_authorization["enabled"] = true
      Rails.configuration.email_authorization["domains"] = ["allowed.com"]

      post user_registration_url, params: user_params("test@disallowed.com")

      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_match(/sorry/i, flash[:error])
    end


    private

    def user_params(email)
      {
        user: {
          email: email,
          password: "password",
          password_confirmation: "password"
        }
      }
    end
  end
end
