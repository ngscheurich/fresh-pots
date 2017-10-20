class BrewsController < ApplicationController
  before_action :set_brew, only: [:show, :edit, :update, :destroy]

  def index
    @brews = Brew.all
  end

  def show
  end

  def new
    @brew = Brew.new
  end

  def edit
  end

  def create
    @brew = Brew.new(brew_params)

    respond_to do |format|
      if @brew.save
        format.html { redirect_to @brew, notice: 'Brew was successfully created.' }
        format.json { render :show, status: :created, location: @brew }
      else
        format.html { render :new }
        format.json { render json: @brew.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @brew.update(brew_params)
        format.html { redirect_to @brew, notice: 'Brew was successfully updated.' }
        format.json { render :show, status: :ok, location: @brew }
      else
        format.html { render :edit }
        format.json { render json: @brew.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @brew.destroy
    respond_to do |format|
      format.html { redirect_to brews_url, notice: 'Brew was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brew
      @brew = Brew.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brew_params
      params.require(:brew).permit(:pot_id)
    end
end
