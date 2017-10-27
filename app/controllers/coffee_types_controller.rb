class CoffeeTypesController < ApplicationController
  include Messageable
  include Renderable
  before_action :set_coffee_type, only: %i[show edit update destroy]

  def index
    @coffee_types = CoffeeType.all
  end

  def show; end

  def new
    @coffee_type = CoffeeType.new
  end

  def edit; end

  def create
    @coffee_type = CoffeeType.new(coffee_type_params)

    respond_to do |format|
      if @coffee_type.save
        format.html { redirect_to @coffee_type, notice: created_message }
        format.json { render :show, status: :created, location: @coffee_type }
      else
        render_errors(:new, @coffee_type)
      end
    end
  end

  def update
    respond_to do |format|
      if @coffee_type.update(coffee_type_params)
        format.html { redirect_to @coffee_type, notice: updated_message }
        format.json { render :show, status: :ok, location: @coffee_type }
      else
        render_errors(:edit, @coffee_type)
      end
    end
  end

  def destroy
    @coffee_type.destroy
    respond_to do |format|
      format.html { redirect_to coffee_types_url, notice: destroyed_message }
      format.json { head :no_content }
    end
  end

  private

  def set_coffee_type
    @coffee_type = CoffeeType.find(params[:id])
  end

  def coffee_type_params
    params.require(:coffee_type).permit(:name)
  end
end
