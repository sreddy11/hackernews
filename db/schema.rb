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

ActiveRecord::Schema.define(:version => 20130628140207) do

  create_table "articles", :force => true do |t|
    t.string   "url",                       :null => false
    t.string   "title",                     :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id"
    t.integer  "rating",     :default => 0, :null => false
  end

  add_index "articles", ["rating"], :name => "index_articles_on_rating"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "rating",           :default => 0, :null => false
  end

  add_index "comments", ["rating"], :name => "index_comments_on_rating"

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "password_digest"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "email"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "user_id"
    t.integer  "up_or_down"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
