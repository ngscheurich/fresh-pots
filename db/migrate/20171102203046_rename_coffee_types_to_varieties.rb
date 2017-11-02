class RenameCoffeeTypesToVarieties < ActiveRecord::Migration[5.1]
  def change
    rename_table :coffee_types, :varieties
    rename_column :brews, :coffee_type_id, :variety_id
  end
end
