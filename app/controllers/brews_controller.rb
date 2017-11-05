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
      redirect_to @brew, notice: created_message
    else
      render :new
    end
  end

  def update
    if @brew.update(brew_params)
      redirect_to @brew, notice: updated_message
    else
      render :edit
    end
  end

  def destroy
    @brew.destroy
    redirect_to brews_url, notice: destroyed_message
  end

  private

  def set_brew
    @brew = Brew.find(params[:id])
  end

  def brew_params
    params.require(:brew).permit(:pot_id, :variety_id)
  end
end
