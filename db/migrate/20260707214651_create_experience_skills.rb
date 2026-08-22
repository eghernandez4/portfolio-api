class CreateExperienceSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :experience_skills do |t|
      t.references :experience, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end

    add_index :experience_skills, [ :experience_id, :skill_id ], unique: true
  end
end
