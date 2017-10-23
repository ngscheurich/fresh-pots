class Users::RegistrationsController < Devise::RegistrationsController
  before_action :email_authorization, only: [:create]

  private
    def email_authorization
      if Rails.configuration.email_authorization["enabled"]
        user_domain = params["user"]["email"].split("@").last
        allowed_domains = Rails.configuration.email_authorization["domains"]
        unless allowed_domains.include?(user_domain)
          flash[:error] = "Sorry, your email address is not authorized for this app."
          redirect_to new_user_registration_url
        end
      end
    end
end
