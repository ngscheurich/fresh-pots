class PagesController < ApplicationController
  def home
    redirect_to dashboard_url if signed_in?

    params[:signed_up] &&
      @toast =
        "A confirmation has been sent to your email." \
        "Check it out before you log in!"
  end

  def dashboard
    fetch_usage_stats
    fetch_brew_stats
    @top_brewers = User.order(brews_count: :desc).limit(3)

    params[:brew_logged] && @toast = "☕ Your brew has been logged!"
  end

  private

  def fetch_usage_stats
    @most_used_pot = Pot.most_used
    @most_brewed_variety = Variety.most_brewed
    @most_active_user = User.most_active
  end

  def fetch_brew_stats
    brew_stats = BrewStats.new
    @brews_by_time = brew_stats.by_time.to_json
    @brews_by_variety = brew_stats.by_variety.to_json
    @brews_by_pot = brew_stats.by_pot.to_json
    @brews_this_week = brew_stats.this_week
  end
end
