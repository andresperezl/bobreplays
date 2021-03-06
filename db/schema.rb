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

ActiveRecord::Schema.define(version: 20150921164906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "video_playings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.integer  "duration"
    t.string   "videoId"
    t.string   "thumbnail"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "uploaded_on"
  end

  create_table "vote_counts", force: :cascade do |t|
    t.integer  "count",       default: 0
    t.datetime "last_win_at"
    t.integer  "video_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string  "username"
    t.integer "video_id"
  end

  add_foreign_key "video_playings", "videos", name: "video_playings_video_id_fk", on_delete: :cascade
  add_foreign_key "vote_counts", "videos", name: "vote_counts_video_id_fk", on_delete: :cascade
  add_foreign_key "votes", "videos", name: "votes_video_id_fk", on_delete: :cascade
end
