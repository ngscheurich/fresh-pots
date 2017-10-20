class CreateBrews < ActiveRecord::Migration[5.1]
  def change
    create_table :brews do |t|
      t.references :pot, foreign_key: true, null: false

      t.timestamps
    end
  end
end
