class CoffeeTypesController < ApplicationController
  before_action :set_coffee_type, only: [:show, :edit, :update, :destroy]

  # GET /coffee_types
  # GET /coffee_types.json
  def index
    @coffee_types = CoffeeType.all
  end

  # GET /coffee_types/1
  # GET /coffee_types/1.json
  def show
  end

  # GET /coffee_types/new
  def new
    @coffee_type = CoffeeType.new
  end

  # GET /coffee_types/1/edit
  def edit
  end

  # POST /coffee_types
  # POST /coffee_types.json
  def create
    @coffee_type = CoffeeType.new(coffee_type_params)

    respond_to do |format|
      if @coffee_type.save
        format.html { redirect_to @coffee_type, notice: 'Coffee type was successfully created.' }
        format.json { render :show, status: :created, location: @coffee_type }
      else
        format.html { render :new }
        format.json { render json: @coffee_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coffee_types/1
  # PATCH/PUT /coffee_types/1.json
  def update
    respond_to do |format|
      if @coffee_type.update(coffee_type_params)
        format.html { redirect_to @coffee_type, notice: 'Coffee type was successfully updated.' }
        format.json { render :show, status: :ok, location: @coffee_type }
      else
        format.html { render :edit }
        format.json { render json: @coffee_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coffee_types/1
  # DELETE /coffee_types/1.json
  def destroy
    @coffee_type.destroy
    respond_to do |format|
      format.html { redirect_to coffee_types_url, notice: 'Coffee type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coffee_type
      @coffee_type = CoffeeType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coffee_type_params
      params.require(:coffee_type).permit(:name)
    end
end
