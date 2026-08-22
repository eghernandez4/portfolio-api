class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :experience, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :repository_url
      t.string :demo_url
      t.date :start_date
      t.date :end_date
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :projects, :display_order
  end
end
