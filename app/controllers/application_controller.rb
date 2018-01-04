class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_flash_message
    return unless cookies[:flash_message]
    @toast = CGI.unescape(cookies[:flash_message])
    cookies.delete(:flash_message)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[full_name avatar]
    )
  end
end
