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

ActiveRecord::Schema.define(:version => 20121128155409) do

  create_table "citizens_questions", :force => true do |t|
    t.integer  "citizen_id"
    t.integer  "question_id"
    t.integer  "hours"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "hours_done",  :default => 0
    t.integer  "teamleader",  :default => 0
    t.integer  "partner_id"
    t.integer  "hours_moved", :default => 0
  end

  add_index "citizens_questions", ["citizen_id", "question_id"], :name => "index_citizens_questions_on_citizen_id_and_question_id", :unique => true
  add_index "citizens_questions", ["citizen_id"], :name => "index_citizens_questions_on_citizen_id"
  add_index "citizens_questions", ["question_id"], :name => "index_citizens_questions_on_question_id"

  create_table "citizens_tasks", :force => true do |t|
    t.integer  "task_id"
    t.integer  "citizen_id"
    t.decimal  "hours",      :precision => 5, :scale => 1
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.decimal  "hours_done", :precision => 5, :scale => 1
  end

  add_index "citizens_tasks", ["citizen_id", "task_id"], :name => "index_citizens_tasks_on_citizen_id_and_task_id", :unique => true
  add_index "citizens_tasks", ["citizen_id"], :name => "index_citizens_tasks_on_citizen_id"
  add_index "citizens_tasks", ["task_id"], :name => "index_citizens_tasks_on_task_id"

  create_table "election_subject_elections", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "election_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "hours"
    t.float    "total"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_citizens", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email",                  :null => false
    t.string   "password_digest",        :null => false
    t.string   "street"
    t.integer  "street_number"
    t.string   "postal_code"
    t.string   "city"
    t.integer  "county_id",              :null => false
    t.string   "gender",                 :null => false
    t.integer  "age",                    :null => false
    t.integer  "position"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "activation_code"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "refinery_citizens", ["county_id"], :name => "index_refinery_citizens_on_county_id"
  add_index "refinery_citizens", ["email"], :name => "index_refinery_citizens_on_email", :unique => true

  create_table "refinery_counties", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "code"
    t.text     "borders"
  end

  add_index "refinery_counties", ["name"], :name => "index_refinery_counties_on_name", :unique => true

  create_table "refinery_election_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "refinery_election_types", ["name"], :name => "index_refinery_election_types_on_name", :unique => true

  create_table "refinery_elections", :force => true do |t|
    t.integer  "election_type_id",                    :null => false
    t.date     "held",                                :null => false
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "done",             :default => false
  end

  add_index "refinery_elections", ["election_type_id", "held"], :name => "index_refinery_elections_on_election_type_id_and_held", :unique => true
  add_index "refinery_elections", ["election_type_id"], :name => "index_refinery_elections_on_election_type_id"

  create_table "refinery_emails", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "content"
    t.string   "for"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "refinery_emails", ["title"], :name => "index_refinery_emails_on_title", :unique => true

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_keepers", :force => true do |t|
    t.string   "firstname",       :null => false
    t.string   "lastname",        :null => false
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.string   "street"
    t.integer  "street_number"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.integer  "position"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "activation_code"
  end

  add_index "refinery_keepers", ["email"], :name => "index_refinery_keepers_on_email", :unique => true

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_f9716c4215584edbca2557e32706a5ae084a15ef"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_d079468f88bff1c6ea81573a0d019ba8bf5c2902"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_parties", :primary_key => "subject_id", :force => true do |t|
    t.string   "name",                  :null => false
    t.text     "parliament_candidates"
    t.text     "senat_candidates"
    t.text     "county_leaders"
    t.integer  "position"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_parties", ["name"], :name => "index_refinery_parties_on_name", :unique => true

  create_table "refinery_politicians", :primary_key => "subject_id", :force => true do |t|
    t.string   "firstname",  :null => false
    t.string   "lastname",   :null => false
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "photo_id"
  end

  add_index "refinery_politicians", ["firstname", "lastname"], :name => "index_refinery_politicians_on_firstname_and_lastname", :unique => true

  create_table "refinery_questions", :force => true do |t|
    t.string   "title",                          :null => false
    t.text     "content",                        :null => false
    t.integer  "election_id"
    t.integer  "subject_id"
    t.integer  "position"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "done",        :default => false
    t.boolean  "disabled",    :default => false
  end

  add_index "refinery_questions", ["title"], :name => "index_refinery_questions_on_title", :unique => true

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",               :null => false
    t.string   "email",                  :null => false
    t.string   "encrypted_password",     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

  create_table "subjects", :force => true do |t|
    t.integer  "keeper_id",  :null => false
    t.string   "subtype",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "subjects", ["keeper_id"], :name => "index_subjects_on_keeper_id"

  create_table "subtasks", :force => true do |t|
    t.integer  "task_id"
    t.text     "content"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.decimal  "hours",       :precision => 6, :scale => 1
    t.decimal  "hours_done",  :precision => 6, :scale => 1
    t.integer  "state",                                     :default => 0
    t.integer  "citizen_id"
    t.datetime "accepted_at"
  end

  create_table "tasks", :force => true do |t|
    t.text     "content"
    t.integer  "question_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.decimal  "hours",       :precision => 5, :scale => 1, :default => 0.0
    t.integer  "state",                                     :default => 0
  end

  add_index "tasks", ["question_id"], :name => "index_tasks_on_question_id"

end
