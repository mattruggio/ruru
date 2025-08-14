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

ActiveRecord::Schema[8.0].define(version: 2025_08_11_003739) do
  create_table "players", force: :cascade do |t|
    t.integer "season_id", null: false
    t.string "code", limit: 20, null: false
    t.string "first_name", limit: 100, default: "", null: false
    t.string "last_name", limit: 100, default: "", null: false
    t.integer "position", null: false
    t.integer "overall", default: 0, null: false
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id", "code"], name: "index_players_on_season_id_and_code", unique: true
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "join_code", limit: 64
    t.string "workflow_state", default: "waiting_for_users", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["join_code"], name: "index_seasons_on_join_code", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "season_id", null: false
    t.integer "user_id"
    t.string "code", limit: 3, default: "", null: false
    t.string "location", limit: 100, default: "", null: false
    t.string "name", limit: 100, default: "", null: false
    t.boolean "admin", default: false, null: false
    t.integer "draft_position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id", "code"], name: "index_teams_on_season_id_and_code", unique: true
    t.index ["season_id", "user_id"], name: "index_teams_on_season_id_and_user_id", unique: true
    t.index ["season_id"], name: "index_teams_on_season_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "sessions", "users"
end
