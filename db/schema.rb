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

ActiveRecord::Schema.define(:version => 20130205224323) do

  create_table "registrations", :force => true do |t|
    t.integer  "weight_class_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "age"
    t.string   "club"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "weight_classes", :force => true do |t|
    t.string   "beginner_elite"
    t.string   "gender"
    t.string   "weight"
    t.string   "age"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
