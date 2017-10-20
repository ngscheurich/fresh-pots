class PotsController < ApplicationController
  before_action :set_pot, only: [:show, :edit, :update, :destroy]

  def index
    @pots = Pot.all
  end

  def show
    @recent_brews = @pot.recent_brews
  end

  def new
    @pot = Pot.new
  end

  def edit
  end

  def create
    @pot = Pot.new(pot_params)

    respond_to do |format|
      if @pot.save
        format.html { redirect_to @pot, notice: 'Pot was successfully created.' }
        format.json { render :show, status: :created, location: @pot }
      else
        format.html { render :new }
        format.json { render json: @pot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pot.update(pot_params)
        format.html { redirect_to @pot, notice: 'Pot was successfully updated.' }
        format.json { render :show, status: :ok, location: @pot }
      else
        format.html { render :edit }
        format.json { render json: @pot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pot.destroy
    respond_to do |format|
      format.html { redirect_to pots_url, notice: 'Pot was successfully destroyed.' }
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
