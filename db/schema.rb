# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_02_190102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "code_1"
    t.string "code_2"
    t.string "code_3"
    t.string "fr_title"
    t.string "en_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "french_embassies", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "coordinates"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_french_embassies_on_country_id"
  end

  create_table "french_foreigners_countings", force: :cascade do |t|
    t.string "year"
    t.integer "number_of_foreigners"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_french_foreigners_countings_on_country_id"
  end

end
