module ApplicationHelper
  def flash_key_to_toast_type(key)
    key_toast_map.fetch(key, "default")
  end

  def pot_select(user)
    select_tag(:"brew[pot_id]", options_for_select(pot_list, user.pot_id))
  end

  def variety_select(user)
    select_tag(:"brew[variety_id]", options_for_select(variety_list, user.variety_id))
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

  def pot_list
    pots = Pot.all.map { |pot| [pot.name, pot.id] }
    pots.unshift(["Which pot are you using?", nil])
  end

  def variety_list
    varieties = Variety.all.map { |variety| [variety.name, variety.id] }
    varieties.unshift(["Which variety are you brewing?", nil])
  end
end
