module ApplicationHelper
  def flash_key_to_toast_type(key)
    key_toast_map.fetch(key, "default")
  end

  private

  def key_toast_map
    {
      "alert" => "warning",
      "error" => "error",
      "info" => "info",
      "notice" => "success"
    }
  end
end
