module Messageable
  extend ActiveSupport::Concern

  def created_message
    "#{model_human_name} was successfully created."
  end

  def updated_message
    "#{model_human_name} was successfully updated."
  end

  def destroyed_message
    "#{model_human_name} was successfully destroyed."
  end

  def model_human_name
    controller_name.singularize.humanize
  end
end
