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

ActiveRecord::Schema.define(version: 20160623113348) do

  create_table "categories", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_pl"
    t.string   "name_zh"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories_posts", id: false, force: :cascade do |t|
    t.integer "post_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.string   "signature"
    t.integer  "post_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ip"
    t.string   "website"
  end

  create_table "images", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.float    "number"
    t.text     "description"
    t.text     "content"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "textile_enabled", default: false
    t.integer  "views",           default: 0
    t.string   "language",        default: "en"
    t.integer  "word_count",      default: 0
    t.integer  "comments_count",  default: 0,     null: false
    t.string   "url"
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id"
  add_index "posts", ["number"], name: "index_posts_on_number"
  add_index "posts", ["url"], name: "index_posts_on_url", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "visits", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "ip"
    t.string   "browser"
    t.string   "city"
    t.string   "country"
    t.datetime "timestamp"
  end

end
