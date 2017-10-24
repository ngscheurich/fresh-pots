module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :email_authorization, only: [:create]

    private

    def email_authorization
      return unless email_opts["enabled"]

      user_domain = params["user"]["email"].split("@").last
      allowed_domains = email_opts["domains"]

      deny_registration unless allowed_domains.include?(user_domain)
    end

    def deny_registration
      custom_message = email_opts["message"]
      flash[:error] = custom_message.nil? ? default_message : custom_message
      redirect_to new_user_registration_url
    end

    def email_opts
      Rails.configuration.email_authorization
    end

    def default_message
      "Sorry, your email address is not authorized for this app."
    end
  end
end
