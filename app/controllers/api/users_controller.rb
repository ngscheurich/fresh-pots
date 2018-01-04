class Api::UsersController < ApiController
  def show
    user = User.find(params[:id])

    user_data = {
      name: user.full_name,
      avatar: user.avatar.url(:thumb)
    }

    render json: user_data
  end

  def sign_out
    request.env["warden"].logout
  end
end
