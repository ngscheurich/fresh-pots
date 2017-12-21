class AddFavoritesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :pot
    add_reference :users, :variety
  end
end
