# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_07_214654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "experience_id", null: false
    t.string "impact"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_achievements_on_experience_id"
  end

  create_table "experience_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "experience_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id", "skill_id"], name: "index_experience_skills_on_experience_id_and_skill_id", unique: true
    t.index ["experience_id"], name: "index_experience_skills_on_experience_id"
    t.index ["skill_id"], name: "index_experience_skills_on_skill_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "company", null: false
    t.datetime "created_at", null: false
    t.boolean "current", default: false, null: false
    t.integer "display_order", default: 0, null: false
    t.string "employment_type"
    t.date "end_date"
    t.string "position", null: false
    t.date "start_date", null: false
    t.text "summary"
    t.datetime "updated_at", null: false
    t.index ["display_order"], name: "index_experiences_on_display_order"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "github_url"
    t.string "headline", null: false
    t.string "linkedin_url"
    t.string "location"
    t.string "name", null: false
    t.integer "singleton_guard", default: 1, null: false
    t.datetime "updated_at", null: false
    t.string "website_url"
    t.index ["singleton_guard"], name: "index_profiles_on_singleton_guard", unique: true
    t.check_constraint "singleton_guard = 1", name: "profiles_singleton_guard_check"
  end

  create_table "project_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "project_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "skill_id"], name: "index_project_skills_on_project_id_and_skill_id", unique: true
    t.index ["project_id"], name: "index_project_skills_on_project_id"
    t.index ["skill_id"], name: "index_project_skills_on_skill_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "demo_url"
    t.text "description"
    t.integer "display_order", default: 0, null: false
    t.date "end_date"
    t.bigint "experience_id", null: false
    t.string "name", null: false
    t.string "repository_url"
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.index ["display_order"], name: "index_projects_on_display_order"
    t.index ["experience_id"], name: "index_projects_on_experience_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.integer "display_order", default: 0, null: false
    t.string "level"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.integer "years"
    t.index ["display_order"], name: "index_skills_on_display_order"
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  add_foreign_key "achievements", "experiences"
  add_foreign_key "experience_skills", "experiences"
  add_foreign_key "experience_skills", "skills"
  add_foreign_key "project_skills", "projects"
  add_foreign_key "project_skills", "skills"
  add_foreign_key "projects", "experiences"
end
