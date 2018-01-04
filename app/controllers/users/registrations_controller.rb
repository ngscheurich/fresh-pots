module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :email_authorization, only: [:create]

    private

    def email_authorization
      config = Rails.configuration.fresh_pots

      return unless config["email_whitelist"]["enabled"]

      user_domain = params["user"]["email"].split("@").last
      allowed_domains = config["email_whitelist"]["domains"]

      deny_registration unless allowed_domains.include?(user_domain)
    end

    def deny_registration
      custom_message = whitelist["message"]
      flash[:error] = custom_message.nil? ? default_message : custom_message
      redirect_to new_user_registration_url
    end

    def whitelist
      Rails.configuration.fresh_pots["email_whitelist"]
    end

    def default_message
      "Sorry, your email address is not authorized for this app."
    end
  end
end
