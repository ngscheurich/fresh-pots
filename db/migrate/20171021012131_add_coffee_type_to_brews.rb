class AddCoffeeTypeToBrews < ActiveRecord::Migration[5.1]
  def change
    add_reference :brews, :coffee_type, foreign_key: true
  end
end
