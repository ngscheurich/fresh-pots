class AddBrewsCountToPots < ActiveRecord::Migration[5.1]
  def change
    add_column :pots, :brews_count, :integer, default: 0
  end
end
