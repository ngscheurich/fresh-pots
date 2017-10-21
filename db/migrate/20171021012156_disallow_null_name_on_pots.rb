class DisallowNullNameOnPots < ActiveRecord::Migration[5.1]
  def up
    change_column :pots, :name, :string, null: false
  end

  def down
    change_column :pots, :name, :string, null: true
  end
end
