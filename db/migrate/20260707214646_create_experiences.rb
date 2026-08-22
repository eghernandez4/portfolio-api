class CreateExperiences < ActiveRecord::Migration[8.1]
  def change
    create_table :experiences, id: :uuid do |t|
      t.references :profiles, null: false, foreign_key: true
      t.string :company, null: false
      t.string :position, null: false
      t.string :employment_type
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :current, default: false, null: false
      t.text :summary
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :experiences, :display_order
  end
end
