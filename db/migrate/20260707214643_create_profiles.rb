class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    # Habilitar la extensión para generar UUIDs en Postgres si no está activa
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :profiles, id: :uuid do |t|
      t.string :name, null: false
      t.string :headline, null: false
      t.text :bio
      t.string :location
      t.string :email
      t.string :linkedin_url
      t.string :github_url
      t.string :website_url
      t.integer :singleton_guard, default: true, null: false

      t.timestamps
    end

    add_index :profiles, :singleton_guard, unique: true
    add_check_constraint :profiles, "singleton_guard = TRUE", name: "profiles_singleton_guard_check"
  end
end
