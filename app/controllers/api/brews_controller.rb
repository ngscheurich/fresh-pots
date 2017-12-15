class Api::BrewsController < ApiController
  def recent
    @recent_brews = recent_available
  end

  def exhaust
    Brew.find(params[:id]).exhaust
    head :no_content
  end

  private

  def recent_available
    max = Rails.configuration.fresh_pots["max_brew_hours"].to_i

    Brew
      .where(created_at: max.hours.ago..Time.current)
      .where(status: :available)
      .order(created_at: :desc)
  end
end
