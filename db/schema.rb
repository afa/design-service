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

ActiveRecord::Schema.define(:version => 20130603131858) do

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

  create_table "attachments", :force => true do |t|
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.text     "text"
  end

  create_table "moderations", :force => true do |t|
    t.integer  "moderable_id"
    t.string   "moderable_type"
    t.boolean  "accepted_first_stage", :default => false
    t.boolean  "accepted_final",       :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "moderations", ["moderable_type", "moderable_id"], :name => "index_moderations_on_moderable_type_and_moderable_id"

  create_table "order_parts", :force => true do |t|
    t.integer  "order_id"
    t.integer  "specialist_id"
    t.string   "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "order_parts", ["order_id"], :name => "index_order_parts_on_order_id"
  add_index "order_parts", ["specialist_id"], :name => "index_order_parts_on_specialist_id"

  create_table "orders", :force => true do |t|
    t.integer  "orderable_id"
    t.string   "orderable_type"
    t.integer  "client_id",                                                       :null => false
    t.string   "completion_status"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.decimal  "price",             :precision => 10, :scale => 2
    t.integer  "reviews_count",                                    :default => 0
  end

  add_index "orders", ["client_id"], :name => "index_orders_on_client_id"
  add_index "orders", ["orderable_id"], :name => "index_orders_on_orderable_id"

  create_table "photo_collections", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "photo"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "title"
    t.integer  "imageable_single_id"
    t.string   "imageable_single_type"
  end

  add_index "photos", ["imageable_single_id"], :name => "index_photos_on_imageable_single_id"
  add_index "photos", ["imageable_single_type"], :name => "index_photos_on_imageable_single_type"

  create_table "plan_developments", :force => true do |t|
    t.boolean  "join_kitchen_with_living_room"
    t.boolean  "cloakroom_needed"
    t.boolean  "cabinet_needed"
    t.integer  "num_builtin_closets"
    t.integer  "num_bedrooms"
    t.boolean  "washing_room_needed"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "num_plans"
    t.integer  "attachment_id",                 :null => false
    t.string   "address"
    t.string   "floor"
    t.string   "section"
    t.integer  "num_standpipes"
    t.integer  "client_id"
    t.string   "num_guests"
    t.string   "big_kitchen"
    t.text     "comment"
    t.text     "family_composition"
  end

  create_table "portfolio_items", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "specialist_id"
  end

  create_table "replanning_attachments", :force => true do |t|
    t.string   "file"
    t.integer  "replanning_endorsement_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "replanning_attachments", ["replanning_endorsement_id"], :name => "index_replanning_attachments_on_replanning_endorsement_id"

  create_table "replanning_endorsements", :force => true do |t|
    t.boolean  "developed_by_general_projector"
    t.boolean  "replanning_organization_licensed"
    t.decimal  "flat_area",                        :precision => 5, :scale => 1
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "text"
  end

  add_index "reviews", ["order_id"], :name => "index_reviews_on_order_id"

  create_table "specialist_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "specialists", :force => true do |t|
    t.integer  "profile_id",          :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "specialist_group_id"
    t.string   "specialization"
  end

  add_index "specialists", ["profile_id"], :name => "index_specialists_on_profile_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "username"
    t.string   "name"
    t.string   "surname"
    t.string   "middle_name"
    t.integer  "access_level"
    t.string   "role",                   :default => "client"
    t.integer  "orders_count",           :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
