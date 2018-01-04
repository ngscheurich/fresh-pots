module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :email_authorization, only: [:create]

    private

    def email_authorization
      user_domain = params["user"]["email"].split("@").last
      allowed_domains = ["theadvocate.com"]

      deny_registration unless allowed_domains.include?(user_domain)
    end

    def deny_registration
      custom_message = whitelist["message"]
      flash[:error] = custom_message.nil? ? default_message : custom_message
      redirect_to new_user_registration_url
    end

    def default_message
      "Sorry, your email address is not authorized for this app."
    end
  end
end
