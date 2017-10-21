class PagesController < ApplicationController
  def home
    @recent_brews = Brew.order(created_at: :desc).first(5)
  end
end
