# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160209020416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "position",   default: 0
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "category_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "category_anc_desc_idx", unique: true, using: :btree
    t.index ["descendant_id"], name: "category_desc_idx", using: :btree
  end

  create_table "choices", force: :cascade do |t|
    t.integer  "category_id"
    t.decimal  "index",       precision: 6, scale: 5
    t.text     "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["category_id"], name: "index_choices_on_category_id", using: :btree
  end

  create_table "communities", force: :cascade do |t|
    t.string   "name"
    t.string   "gnis_id"
    t.string   "census_id"
    t.text     "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_communities_on_slug", unique: true, using: :btree
  end

  create_table "index_category_choices", force: :cascade do |t|
    t.integer  "index_id"
    t.integer  "choice_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_index_category_choices_on_category_id", using: :btree
    t.index ["choice_id"], name: "index_index_category_choices_on_choice_id", using: :btree
    t.index ["index_id"], name: "index_index_category_choices_on_index_id", using: :btree
  end

  create_table "indices", force: :cascade do |t|
    t.datetime "finalized_at"
    t.integer  "awrvi_version_id",                         null: false
    t.integer  "community_id"
    t.decimal  "awrvi_index",      precision: 6, scale: 5
    t.datetime "rejected_at"
    t.text     "rejected_reason"
    t.integer  "user_id"
    t.index ["awrvi_version_id"], name: "index_indices_on_awrvi_version_id", using: :btree
    t.index ["community_id"], name: "index_indices_on_community_id", using: :btree
    t.index ["user_id"], name: "index_indices_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "choices", "categories"
  add_foreign_key "index_category_choices", "categories"
  add_foreign_key "index_category_choices", "choices"
  add_foreign_key "index_category_choices", "indices"
  add_foreign_key "indices", "categories", column: "awrvi_version_id"
  add_foreign_key "indices", "communities"
  add_foreign_key "indices", "users"
end
