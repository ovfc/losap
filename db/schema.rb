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

ActiveRecord::Schema.define(:version => 20110529180302) do

  create_table "admins", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_request_at"
  end

  create_table "admins_roles", :id => false, :force => true do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id"], :name => "index_admins_roles_on_admin_id"
  add_index "admins_roles", ["role_id"], :name => "index_admins_roles_on_role_id"

  create_table "locked_months", :force => true do |t|
    t.date     "month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "badgeno",    :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sleep_ins", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.integer  "unit_type_id"
    t.boolean  "deleted",      :default => false, :null => false
  end

  add_index "sleep_ins", ["member_id"], :name => "index_sleep_ins_on_member_id"
  add_index "sleep_ins", ["unit_type_id"], :name => "index_sleep_ins_on_unit_type_id"

  create_table "standbys", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.boolean  "deleted",    :default => false, :null => false
  end

  add_index "standbys", ["member_id"], :name => "index_standbys_on_member_id"

  create_table "unit_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
