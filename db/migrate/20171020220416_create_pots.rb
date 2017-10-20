class CreatePots < ActiveRecord::Migration[5.1]
  def change
    create_table :pots do |t|
      t.string :name

      t.timestamps
    end
  end
end
