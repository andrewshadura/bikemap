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

ActiveRecord::Schema.define(:version => 20120718091508) do

  create_table "comments", :force => true do |t|
    t.text     "text",      :null => false
    t.datetime "posted_on", :null => false
  end

  create_table "features", :force => true do |t|
    t.spatial  "geometry",    :limit => {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.string   "name"
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
    t.integer  "rating",                                                                     :default => 0
    t.string   "description"
    t.integer  "capacity"
    t.text     "comment"
  end

end
