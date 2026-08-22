class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.string :category
      t.string :level
      t.integer :years
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :skills, :name, unique: true
    add_index :skills, :display_order
  end
end
