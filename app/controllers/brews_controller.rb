class BrewsController < ApplicationController
  include Messageable
  include Renderable
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

    respond_to do |format|
      if @brew.save
        format.html { redirect_to @brew, notice: created_message }
        format.json { render :show, status: :created, location: @brew }
      else
        render_errors(:new, @brew)
      end
    end
  end

  def update
    respond_to do |format|
      if @brew.update(brew_params)
        format.html { redirect_to @brew, notice: updated_message }
        format.json { render :show, status: :ok, location: @brew }
      else
        render_errors(:edit, @brew)
      end
    end
  end

  def destroy
    @brew.destroy
    respond_to do |format|
      format.html { redirect_to brews_url, notice: destroyed_message }
      format.json { head :no_content }
    end
  end

  private

  def set_brew
    @brew = Brew.find(params[:id])
  end

  def brew_params
    params.require(:brew).permit(:pot_id, :coffee_type_id)
  end
end
