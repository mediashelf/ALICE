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

ActiveRecord::Schema.define(:version => 20120904201217) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "assets", :force => true do |t|
    t.string   "title"
    t.integer  "year"
    t.string   "source"
    t.string   "state"
    t.string   "format"
    t.string   "level"
    t.string   "type_of"
    t.text     "summary"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "asset_file"
    t.text     "content"
    t.string   "bill_number"
    t.string   "external_link_to_asset"
    t.string   "short_title"
    t.string   "source_website"
    t.text     "alternative_terms"
    t.string   "legislative_history"
    t.text     "notes"
    t.string   "bill_pdf"
    t.text     "bill_pdf_content"
    t.string   "bill_word"
    t.string   "asset_word"
  end

  create_table "assets_topics", :id => false, :force => true do |t|
    t.integer "asset_id"
    t.integer "topic_id"
  end

  add_index "assets_topics", ["asset_id", "topic_id"], :name => "index_assets_topics_on_asset_id_and_topic_id"
  add_index "assets_topics", ["topic_id", "asset_id"], :name => "index_assets_topics_on_topic_id_and_asset_id"

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "document_id"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "user_type"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "parent_id"
    t.string   "slug"
    t.boolean  "is_home_page", :default => false
  end

  create_table "policy_areas", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "searches", :force => true do |t|
    t.text     "query_params"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "user_type"
  end

  add_index "searches", ["user_id"], :name => "index_searches_on_user_id"

  create_table "sub_areas", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "policy_area_id"
  end

  add_index "sub_areas", ["policy_area_id"], :name => "index_sub_areas_on_policy_area_id"

  create_table "sub_areas_topics", :id => false, :force => true do |t|
    t.integer "sub_area_id"
    t.integer "topic_id"
  end

  add_index "sub_areas_topics", ["sub_area_id"], :name => "index_sub_areas_topics_on_sub_area_id"
  add_index "sub_areas_topics", ["topic_id"], :name => "index_sub_areas_topics_on_topic_id"

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
