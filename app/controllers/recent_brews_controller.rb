class RecentBrewsController < ApplicationController
  def index
    @recent_brews = Brew.order(created_at: :desc).first(10)
  end
end

