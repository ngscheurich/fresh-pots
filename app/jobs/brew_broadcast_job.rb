class BrewBroadcastJob < ApplicationJob
  queue_as :default

  def perform(brew)
    ActionCable.server.broadcast "brews", render_brew(brew)
  end

  private

  def render_brew(brew)
    ApplicationController.render(
      partial: "api/brews/brew",
      locals: { brew: brew }
    )
  end
end
