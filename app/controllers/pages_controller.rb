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
    @recent_brews = Brew.order(created_at: :desc).first(5)
    @most_used_pot = Pot.most_used
    @most_brewed_variety = Variety.most_brewed
    @most_active_user = User.most_active
  end
end
