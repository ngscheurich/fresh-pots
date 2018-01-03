class UsersController < ApplicationController
  include Messageable
  before_action :set_user, only: %i[show edit update]
  before_action :ensure_correct_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: updated_message
    else
      render :edit
    end
  end

  def me
    redirect_to current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    return if current_user.id == @user.id
    flash[:error] = "You can’t do that!"
    redirect_to user_path(current_user)
  end

  def user_params
    params.require(:user).permit(
      :full_name,
      :first_name,
      :last_name,
      :avatar,
      :pot_id,
      :variety_id
    )
  end
end
