class PotsController < ApplicationController
  before_action :set_pot, only: [:show, :edit, :update, :destroy]

  # GET /pots
  # GET /pots.json
  def index
    @pots = Pot.all
  end

  # GET /pots/1
  # GET /pots/1.json
  def show
  end

  # GET /pots/new
  def new
    @pot = Pot.new
  end

  # GET /pots/1/edit
  def edit
  end

  # POST /pots
  # POST /pots.json
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

  # PATCH/PUT /pots/1
  # PATCH/PUT /pots/1.json
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

  # DELETE /pots/1
  # DELETE /pots/1.json
  def destroy
    @pot.destroy
    respond_to do |format|
      format.html { redirect_to pots_url, notice: 'Pot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pot
      @pot = Pot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pot_params
      params.require(:pot).permit(:name)
    end
end
