class AddUserIdToBrews < ActiveRecord::Migration[5.1]
  def change
    add_reference :brews, :user, foreign_key: true
  end
end
