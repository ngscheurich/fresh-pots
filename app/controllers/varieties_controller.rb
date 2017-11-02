class VarietiesController < ApplicationController
  include Messageable
  before_action :set_variety, only: %i[show edit update destroy]

  def index
    @varieties = Variety.all
  end

  def show; end

  def new
    @variety = Variety.new
  end

  def edit; end

  def create
    @variety = Variety.new(variety_params)

    if @variety.save
      redirect_to @variety, notice: created_message
    else
      render :new
    end
  end

  def update
    if @variety.update(variety_params)
      redirect_to @variety, notice: updated_message
    else
      render :edit
    end
  end

  def destroy
    @variety.destroy
    redirect_to varieties_url, notice: destroyed_message
  end

  private

  def set_variety
    @variety = Variety.find(params[:id])
  end

  def variety_params
    params.require(:variety).permit(:name)
  end
end
