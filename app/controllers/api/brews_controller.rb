class Api::BrewsController < ApiController
  def recent
    max = Rails.configuration.fresh_pots["max_brew_hours"].to_i
    @recent_brews = Brew.where(created_at: max.hours.ago..Time.current)
                        .order(created_at: :desc)
  end

  def destroy
    brew = Brew.find(params[:id])
    brew.destroy
    head :no_content
  end
end
