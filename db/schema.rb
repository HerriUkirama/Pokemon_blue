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

ActiveRecord::Schema[7.0].define(version: 2023_01_13_045818) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "initiate_skills", force: :cascade do |t|
    t.bigint "pokedex_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokedex_id"], name: "index_initiate_skills_on_pokedex_id"
    t.index ["skill_id"], name: "index_initiate_skills_on_skill_id"
  end

  create_table "pokedexes", force: :cascade do |t|
    t.string "name"
    t.integer "max_hp"
    t.integer "max_exp"
    t.integer "attack"
    t.integer "defence"
    t.integer "speed"
    t.integer "special"
    t.string "element_1"
    t.string "element_2"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.bigint "pokedex_id"
    t.string "name"
    t.integer "pokemon_hp"
    t.integer "pokemon_max_hp"
    t.integer "pokemon_attack"
    t.integer "pokemon_defence"
    t.integer "pokemon_speed"
    t.integer "pokemon_special"
    t.integer "level", default: 1
    t.integer "pokemon_max_exp"
    t.integer "pokemon_exp", default: 0
    t.string "status", default: "Free"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokedex_id"], name: "index_pokemons_on_pokedex_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "pp"
    t.integer "power"
    t.integer "level"
    t.string "element"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end