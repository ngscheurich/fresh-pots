require "rails_helper"

describe Users::RegistrationsController do
  describe "POST #create" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context "when email authorization is disabled" do
      it "should allow any email address for signup" do
        Rails.configuration.email_authorization["enabled"] = false

        post :create, params: user_params("test@example.com")

        expect(flash[:notice]).to match(/activate your account/)
      end
    end

    context "when email authorization is enabled" do
      before(:all) do
        Rails.configuration.email_authorization["enabled"] = true
        Rails.configuration.email_authorization["domains"] = ["allowed.com"]
      end

      it "should allow whitelisted domains" do
        post :create, params: user_params("test@allowed.com")
        expect(flash[:notice]).to match(/activate your account/)
      end

      it "should disallow non-whitelisted domains" do
        post :create, params: user_params("test@disallowed.com")
        expect(flash[:error]).to match(/not authorized/)
      end
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