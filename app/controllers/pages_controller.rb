class PagesController < ApplicationController
  def home
    if signed_in?
      redirect_to dashboard_url
    else
      redirect_to signup_url
    end
  end

  def dashboard
    redirect_to root_url unless signed_in?
    fetch_usage_stats
    fetch_brew_stats
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
