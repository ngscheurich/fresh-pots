module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :email_authorization, only: [:create]

    private

    def email_authorization
      config = Rails.configuration.fresh_pots

      return unless config["email_whitelist"]["enabled"]

      logger.debug "----------------"
      logger.debug config
      logger.debug "----------------"

      user_domain = params["user"]["email"].split("@").last
      allowed_domains = config["email_whitelist"]["domains"]

      logger.debug "----------------"
      logger.debug allowed_domains.include?(user_domain)
      logger.debug "----------------"

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
