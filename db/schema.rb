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

ActiveRecord::Schema.define(:version => 20140404163811) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "reply"
    t.integer  "post_id"
    t.integer  "subreddit_id"
    t.integer  "karma",        :default => 0
  end

  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "url"
    t.string   "subname"
    t.integer  "karma",       :default => 0
    t.boolean  "is_link"
  end

  add_index "posts", ["user_id", "created_at"], :name => "index_posts_on_user_id_and_created_at"

  create_table "replies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "replies", ["comment_id"], :name => "index_replies_on_comment_id"
  add_index "replies", ["user_id"], :name => "index_replies_on_user_id"

  create_table "subreddits", :force => true do |t|
    t.string   "subname"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "title"
    t.string   "description"
    t.integer  "user_count",  :default => 0
  end

  add_index "subreddits", ["user_id", "created_at"], :name => "index_subreddits_on_user_id_and_created_at"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subreddit_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "subscriptions", ["subreddit_id"], :name => "index_subscriptions_on_subreddit_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "remember_token"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "admin"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "direction"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "comment_id"
  end

  add_index "votes", ["comment_id"], :name => "index_votes_on_comment_id"
  add_index "votes", ["post_id"], :name => "index_votes_on_post_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
