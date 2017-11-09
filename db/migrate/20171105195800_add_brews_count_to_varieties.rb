class AddBrewsCountToVarieties < ActiveRecord::Migration[5.1]
  def change
    add_column :varieties, :brews_count, :integer, default: 0
  end
end
