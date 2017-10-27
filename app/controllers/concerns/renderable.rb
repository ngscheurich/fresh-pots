module Renderable
  extend ActiveSupport::Concern

  def render_errors(action, record)
    format.html { render action }
    format.json { render json: record.errors, status: :unprocessable_entity }
  end
end
