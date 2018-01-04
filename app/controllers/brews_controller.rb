class BrewsController < ApplicationController
  include Messageable
  before_action :set_brew, only: %i[show edit update destroy]

  def index
    @brews = Brew.all
  end

  def show; end

  def new
    @brew = Brew.new
  end

  def edit; end

  def create
    @brew = Brew.new(brew_params)
    @brew.user = current_user

    if @brew.save
      ensure_user_favorites(current_user)
      cookies[:flash_message] = request.headers["Flash-Message"]
      head :ok
    else
      render :new
    end
  end

  def update
    if @brew.update(brew_params)
      cookies[:flash_message] = request.headers["Flash-Message"]
    else
      render :edit
    end
  end

  def destroy
    @brew.destroy
    redirect_to brews_url, notice: destroyed_message
  end

  private

  def ensure_user_favorites(user)
    ensure_user_pot(user)
    ensure_user_variety(user)
  end

  def ensure_user_pot(user)
    return if user.pot_id

    user.pot_id = brew_params[:pot_id]
    try_save_user(user)
  end

  def ensure_user_variety(user)
    return if user.variety_id

    user.variety_id = brew_params[:variety_id]
    try_save_user(user)
  end

  def try_save_user(user)
    return if user.save

    flash[:error] = "Could not set user favorites."
    render :new
  end

  def set_brew
    @brew = Brew.find(params[:id])
  end

  def brew_params
    params.require(:brew).permit(:pot_id, :variety_id)
  end
end
