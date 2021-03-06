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

ActiveRecord::Schema.define(version: 20130402142127) do

  create_table "assets", force: true do |t|
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
  end

  create_table "comments", force: true do |t|
    t.text     "content",                      null: false
    t.integer  "status",          default: 0,  null: false
    t.string   "author",          default: "", null: false
    t.string   "email",           default: "", null: false
    t.string   "url",             default: "", null: false
    t.integer  "post_id",         default: 0,  null: false
    t.string   "ip",              default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_display",              null: false
  end

  create_table "posts", force: true do |t|
    t.string   "title",                                  null: false
    t.text     "content",                                null: false
    t.text     "content_display",                        null: false
    t.integer  "status",          limit: 1,              null: false
    t.integer  "post_time",                 default: 0,  null: false
    t.integer  "user_id",                   default: 0,  null: false
    t.string   "url",                                    null: false
    t.string   "short_url",                 default: "", null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "posts_tags", force: true do |t|
    t.integer "post_id", default: 0, null: false
    t.integer "tag_id",  default: 0, null: false
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name",                  null: false
    t.integer "frequency", default: 0, null: false
  end

  create_table "users", force: true do |t|
    t.string   "name",            default: "", null: false
    t.string   "password_digest", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
