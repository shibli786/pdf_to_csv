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

ActiveRecord::Schema.define(version: 20171029103315) do

  create_table "wb_va_trans_portname_indices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "last_date_updated"
    t.text     "comment",           limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["name"], name: "name", type: :fulltext
  end

  create_table "wb_variable_annuity_company_account", primary_key: "wb_account_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "wb_company_id"
    t.string   "wb_account_name",                                 null: false
    t.string   "wb_asset_class",                                               collation: "utf8mb4_general_ci"
    t.string   "wb_category",                                                  collation: "utf8mb4_general_ci"
    t.datetime "wb_inception_date"
    t.boolean  "wb_is_deleted"
    t.datetime "wb_created_date"
    t.datetime "wb_updated_date"
    t.decimal  "wb_ytd_market_close",   precision: 15, scale: 13
    t.decimal  "wb_since_inception",    precision: 15, scale: 13
    t.datetime "wb_date"
    t.decimal  "wb_ytd_month_end",      precision: 15, scale: 13
    t.datetime "wb_ytd_month_end_date"
    t.decimal  "wb_ytd_quarter_end",    precision: 15, scale: 13
    t.datetime "wb_quarter_date"
    t.decimal  "wb_ytd_year_end",       precision: 15, scale: 13
    t.datetime "wb_year_date"
    t.decimal  "wb_ytd_avg_one_year",   precision: 15, scale: 13
    t.decimal  "wb_ytd_avg_three_year", precision: 15, scale: 13
    t.decimal  "wb_ytd_avg_five_year",  precision: 15, scale: 13
    t.decimal  "wb_ytd_avg_ten_year",   precision: 15, scale: 13
    t.integer  "wb_is_active"
    t.integer  "wb_asset_class_id"
    t.integer  "wb_va_product_id"
    t.integer  "wb_va_fund_id"
    t.index ["wb_asset_class_id"], name: "ix_wb_asset_class_id", using: :btree
    t.index ["wb_company_id"], name: "ix_wb_company_id", using: :btree
    t.index ["wb_va_product_id"], name: "ix_wb_va_product_id", using: :btree
  end

end
