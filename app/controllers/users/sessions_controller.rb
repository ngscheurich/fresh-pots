class Users::SessionsController < Devise::SessionsController
  after_action :set_user_id_cookie, only: :create
  after_action :delete_user_id_cookie, only: :destroy
  protect_from_forgery except: :destroy

  private

  def set_user_id_cookie
    cookies[:user_id] = current_user.id
  end

  def delete_user_id_cookie
    cookies.delete(:user_id)
  end
end
