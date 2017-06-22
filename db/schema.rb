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

ActiveRecord::Schema.define(version: 20170622175852) do

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "title"
    t.integer  "lesson_id"
    t.integer  "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "main_image"
    t.string   "minor_image"
    t.boolean  "is_free",     default: false
    t.integer  "category_id"
    t.integer  "weight"
    t.text     "intro"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "effect"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "price",      precision: 10, scale: 2
    t.integer  "user_id"
    t.integer  "payment_id"
    t.string   "token"
    t.boolean  "is_paid",                             default: false
    t.datetime "payment_at"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "payment_no"
    t.string   "transaction_no"
    t.boolean  "is_paid",                                 default: false
    t.decimal  "price",          precision: 10, scale: 2
    t.datetime "payment_at"
    t.text     "raw_response"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "phone_tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "phone"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone", "token"], name: "index_phone_tokens_on_phone_and_token"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.integer  "lesson_id"
    t.integer  "chapter_id"
    t.integer  "weight"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "phone"
    t.boolean  "is_admin",                        default: false
    t.boolean  "is_vip",                          default: false
    t.datetime "expriy_date"
    t.string   "user_image"
    t.string   "wechat"
    t.string   "contact_phone"
    t.string   "user_name"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "vip_prices", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price",      precision: 10, scale: 2
    t.integer  "weight"
    t.boolean  "is_hidden",                           default: true
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

end
