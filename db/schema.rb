# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_24_034942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "language_code", default: "en"
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.string "uuid"
    t.integer "question_id"
    t.string "question_code"
    t.string "value"
    t.integer "score"
    t.string "user_uuid"
    t.string "quiz_uuid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "audio"
    t.text "description"
    t.string "type"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "last", default: false
    t.string "uuid"
    t.boolean "is_video"
    t.string "hint"
    t.string "hint_image"
    t.string "hint_audio"
    t.index ["lft"], name: "index_categories_on_lft"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["rgt"], name: "index_categories_on_rgt"
  end

  create_table "category_images", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "category_uuid"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "type", null: false
    t.string "value", default: ""
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_contacts_on_institution_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "country_institutions", force: :cascade do |t|
    t.string "country_code", default: ""
    t.bigint "institution_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_country_institutions_on_country_id"
    t.index ["institution_id"], name: "index_country_institutions_on_institution_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "kind", default: 2, comment: "ex: ngo, gov. agency, other (default)"
    t.text "address", default: ""
    t.string "logo"
    t.string "audio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_institutions_on_name"
  end

  create_table "criteria", force: :cascade do |t|
    t.integer "question_id"
    t.string "question_code"
    t.string "operator"
    t.string "response_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "form_type"
    t.integer "version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "audio"
  end

  create_table "migrants", force: :cascade do |t|
    t.string "full_name"
    t.string "age"
    t.string "sex"
    t.string "phone_number"
    t.string "voice"
    t.string "uuid"
    t.datetime "registered_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "contacts", "institutions"
  add_foreign_key "country_institutions", "countries"
  add_foreign_key "country_institutions", "institutions"

  create_table "options", force: :cascade do |t|
    t.integer "question_id"
    t.string "name"
    t.string "value"
    t.integer "score"
    t.string "alert_audio"
    t.text "alert_message"
    t.boolean "warning"
    t.boolean "recursive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

  create_table "questions", force: :cascade do |t|
    t.string "code"
    t.text "name"
    t.string "type"
    t.string "hint"
    t.integer "display_order"
    t.string "relevant"
    t.boolean "required"
    t.string "audio"
    t.integer "passing_score"
    t.text "passing_message"
    t.string "passing_audio"
    t.text "failing_message"
    t.string "failing_audio"
    t.integer "form_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "uuid"
    t.string "user_uuid"
    t.integer "form_id"
    t.datetime "quizzed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid"
    t.string "full_name"
    t.string "sex"
    t.string "age"
    t.string "audio"
    t.datetime "registered_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end
