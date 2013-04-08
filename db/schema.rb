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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130407043842) do

  create_table "followers", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "followers", ["user_id"], :name => "index_followers_on_user_id"

  create_table "friends", :force => true do |t|
    t.integer  "friend_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "game_scores", :force => true do |t|
    t.integer  "game_id"
    t.integer  "max_score"
    t.integer  "ranking"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "game_scores", ["user_id"], :name => "index_game_scores_on_user_id"

  create_table "games", :force => true do |t|
    t.string   "title"
    t.integer  "players"
    t.text     "description"
    t.string   "category"
    t.integer  "difficulty"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "from"
    t.datetime "sent_date"
    t.text     "mssg_content"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "profile_photo"
    t.string   "wishlist"
    t.boolean  "android_or_iphone"
    t.string   "country"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "overall_score"
    t.datetime "ranking_since"
    t.integer  "overall_ranking"
    t.string   "mail"
    t.string   "language"
  end

end
