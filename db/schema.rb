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

ActiveRecord::Schema[8.1].define(version: 2026_04_19_214556) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "series", id: :serial, force: :cascade do |t|
    t.string "basket", limit: 20, null: false
    t.string "country_code", limit: 2, null: false
    t.string "country_name", limit: 100, null: false
    t.datetime "created_at", null: false
    t.string "frequency", limit: 20, null: false
    t.string "series_type", limit: 20, null: false
    t.datetime "updated_at", null: false

    t.check_constraint "basket::text = ANY (ARRAY['narrow'::character varying, 'broad'::character varying]::text[])", name: "basket_valid"
    t.check_constraint "country_code::text = upper(country_code::text)", name: "country_code_uppercase"
    t.check_constraint "country_name::text = lower(country_name::text)", name: "country_name_lowercase"
    t.check_constraint "frequency::text = 'monthly'::text", name: "frequency_valid"
    t.check_constraint "series_type::text = ANY (ARRAY['nominal'::character varying, 'real'::character varying]::text[])", name: "series_type_valid"
    t.unique_constraint ["country_code", "basket", "frequency", "series_type"], name: "unique_series"
  end
end
