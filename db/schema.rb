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

ActiveRecord::Schema.define(:version => 20130324152802) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.string   "floor"
    t.string   "section"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flat_infos", :force => true do |t|
    t.integer  "address_id"
    t.integer  "num_standpipes"
    t.integer  "family_composition_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "flat_infos", ["address_id"], :name => "index_flat_infos_on_address_id"
  add_index "flat_infos", ["family_composition_id"], :name => "index_flat_infos_on_family_composition_id"

  create_table "messages", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "text_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["from_id"], :name => "index_messages_on_from_id"
  add_index "messages", ["text_id"], :name => "index_messages_on_text_id"
  add_index "messages", ["to_id"], :name => "index_messages_on_to_id"

  create_table "moderable_texts", :force => true do |t|
    t.text     "original_text"
    t.text     "moderated_text"
    t.boolean  "verified",       :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "rejected",       :default => false
  end

  create_table "plan_developments", :force => true do |t|
    t.boolean  "join_kitchen_with_living_room"
    t.boolean  "big_kitchen"
    t.boolean  "cloakroom_needed"
    t.boolean  "cabinet_needed"
    t.integer  "num_builtin_closets"
    t.integer  "num_guests"
    t.integer  "num_bedrooms"
    t.boolean  "washing_room_needed"
    t.integer  "flat_info_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "num_plans"
    t.integer  "attachment_id"
    t.integer  "comment_id"
  end

  add_index "plan_developments", ["flat_info_id"], :name => "index_plan_developments_on_flat_info_id"

  create_table "replanning_endorsements", :force => true do |t|
    t.boolean  "developed_by_general_projector"
    t.boolean  "replanning_organization_licensed"
    t.decimal  "flat_area",                        :precision => 5, :scale => 1
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
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
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
