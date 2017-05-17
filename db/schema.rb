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

ActiveRecord::Schema.define(version: 20170517135534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgroonga"

  create_table "admins", id: :serial, force: :cascade do |t|
    t.string "display_name", null: false
    t.boolean "super_admin", default: false
    t.boolean "enabled", default: true
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "blocklists", id: :serial, force: :cascade do |t|
    t.string "description"
    t.string "image_hash"
    t.inet "ip"
    t.string "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "blocked_until", null: false
    t.index "ip inet_ops", name: "index_blocklists_on_ip_inet_ops", using: :gist
    t.index ["blocked_until"], name: "index_blocklists_on_blocked_until"
    t.index ["client_id"], name: "index_blocklists_on_client_id"
    t.index ["image_hash"], name: "index_blocklists_on_image_hash"
  end

  create_table "complaints", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "ip", null: false
    t.string "status", default: "open", null: false
    t.integer "post_id"
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_complaints_on_status"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "parent_post_id"
    t.integer "admin_id"
    t.string "title"
    t.string "author"
    t.string "email"
    t.string "ip", null: false
    t.string "identity_hash", null: false
    t.text "message"
    t.string "image_dimensions"
    t.string "delete_password"
    t.boolean "locked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "tripcode"
    t.integer "reply_count"
    t.string "client_id"
    t.index ["admin_id"], name: "index_posts_on_admin_id"
    t.index ["author"], name: "index_posts_on_author", using: :pgroonga
    t.index ["client_id"], name: "index_posts_on_client_id"
    t.index ["delete_password"], name: "index_posts_on_delete_password"
    t.index ["email"], name: "index_posts_on_email", using: :pgroonga
    t.index ["identity_hash"], name: "index_posts_on_identity_hash"
    t.index ["ip"], name: "index_posts_on_ip"
    t.index ["message"], name: "index_posts_on_message", using: :pgroonga
    t.index ["parent_post_id", "id"], name: "index_posts_on_parent_post_id_and_id"
    t.index ["parent_post_id"], name: "index_posts_on_parent_post_id"
    t.index ["title"], name: "index_posts_on_title", using: :pgroonga
    t.index ["tripcode"], name: "index_posts_on_tripcode"
    t.index ["updated_at"], name: "index_posts_on_updated_at"
  end

end
