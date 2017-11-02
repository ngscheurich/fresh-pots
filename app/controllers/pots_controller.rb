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

    respond_to do |format|
      if @pot.save
        format.html { redirect_to @pot, notice: created_message }
        format.json { render :show, status: :created, location: @pot }
      else
        render_errors(:new, @brew)
      end
    end
  end

  def update
    respond_to do |format|
      if @pot.update(pot_params)
        format.html { redirect_to @pot, notice: updated_message }
        format.json { render :show, status: :ok, location: @pot }
      else
        render_errors(:edit, @brew)
      end
    end
  end

  def destroy
    @pot.destroy
    respond_to do |format|
      format.html { redirect_to pots_url, notice: destroyed_message }
      format.json { head :no_content }
    end
  end

  private

  def set_pot
    @pot = Pot.find(params[:id])
  end

  def pot_params
    params.require(:pot).permit(:name)
  end
end
