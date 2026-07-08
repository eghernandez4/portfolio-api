class CreateAchievements < ActiveRecord::Migration[8.1]
  def change
    create_table :achievements do |t|
      t.references :experience, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :impact

      t.timestamps
    end
  end
end
