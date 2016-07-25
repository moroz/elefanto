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
    t.string   "name_en",     limit: 255
    t.string   "name_pl",     limit: 255
    t.string   "name_zh",     limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "categories_posts", id: false, force: :cascade do |t|
    t.integer "post_id",     limit: 4, null: false
    t.integer "category_id", limit: 4, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text",       limit: 65535
    t.string   "signature",  limit: 255
    t.integer  "post_id",    limit: 4,     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "ip",         limit: 255
    t.string   "website",    limit: 255
  end

  create_table "images", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.string   "url",         limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.float    "number",          limit: 24
    t.text     "description",     limit: 65535
    t.text     "content",         limit: 65535
    t.integer  "category_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "textile_enabled",               default: false
    t.integer  "views",           limit: 4,     default: 0
    t.string   "language",        limit: 255,   default: "en"
    t.integer  "word_count",      limit: 4,     default: 0
    t.integer  "comments_count",  limit: 4,     default: 0,     null: false
    t.string   "url",             limit: 255
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree
  add_index "posts", ["number"], name: "index_posts_on_number", using: :btree
  add_index "posts", ["url"], name: "index_posts_on_url", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",         limit: 255
    t.string   "password_hash", limit: 255
    t.string   "password_salt", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "visits", force: :cascade do |t|
    t.integer  "post_id",   limit: 4
    t.string   "ip",        limit: 255
    t.string   "browser",   limit: 255
    t.string   "city",      limit: 255
    t.string   "country",   limit: 255
    t.datetime "timestamp"
  end

end
