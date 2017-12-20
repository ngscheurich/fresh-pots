class BrewsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "brews"
  end
end
