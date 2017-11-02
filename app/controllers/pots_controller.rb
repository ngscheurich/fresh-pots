class PotsController < ApplicationController
  include Messageable
  before_action :set_pot, only: %i[show edit update destroy]

  def index
    @pots = Pot.all
  end

  def show
    @recent_brews = @pot.recent_brews
  end

  def new
    @pot = Pot.new
  end

  def edit; end

  def create
    @pot = Pot.new(pot_params)

    if @pot.save
      redirect_to @pot, notice: created_message
    else
      render :new
    end
  end

  def update
    if @pot.update(pot_params)
      redirect_to @pot, notice: updated_message
    else
      render :edit
    end
  end

  def destroy
    @pot.destroy
    redirect_to pots_url, notice: destroyed_message
  end

  private

  def set_pot
    @pot = Pot.find(params[:id])
  end

  def pot_params
    params.require(:pot).permit(:name)
  end
end
