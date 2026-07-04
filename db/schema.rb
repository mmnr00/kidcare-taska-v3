# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_03_125527) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"

  create_table "addtns", force: :cascade do |t|
    t.float "amount"
    t.datetime "created_at", precision: nil, null: false
    t.string "desc"
    t.integer "payment_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.boolean "spv"
    t.string "tnc"
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "anisatts", force: :cascade do |t|
    t.integer "anisprog_id"
    t.boolean "att"
    t.integer "course_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "tchdetail_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "anisfeeds", force: :cascade do |t|
    t.string "bad"
    t.integer "course_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "good"
    t.integer "rate"
    t.integer "tchdetail_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "anisprogs", force: :cascade do |t|
    t.integer "course_id"
    t.datetime "created_at", precision: nil, null: false
    t.time "end"
    t.string "lec"
    t.string "name"
    t.time "start"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "applvs", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.date "end"
    t.string "kind"
    t.date "start"
    t.string "stat"
    t.integer "taska_id"
    t.string "tchdesc"
    t.integer "teacher_id"
    t.float "tot"
    t.string "tskdesc"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.float "base_fee"
    t.string "classroom_name"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "colleges", force: :cascade do |t|
    t.boolean "acv"
    t.string "address"
    t.boolean "appl"
    t.datetime "clse", precision: nil
    t.string "collection_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "end"
    t.string "name"
    t.date "start"
    t.string "thm"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["collection_id"], name: "index_colleges_on_collection_id", unique: true
    t.index ["name"], name: "index_colleges_on_name", unique: true
  end

  create_table "courses", force: :cascade do |t|
    t.float "base_fee"
    t.integer "college_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.date "end"
    t.string "name"
    t.date "start"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string "catg"
    t.string "coname"
    t.decimal "cost"
    t.datetime "created_at", precision: nil, null: false
    t.date "dt"
    t.string "kind"
    t.integer "month"
    t.string "name"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "year"
  end

  create_table "extras", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.float "price"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "anisfeed_id"
    t.integer "anisprog_id"
    t.integer "classroom_id"
    t.integer "course_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "rating"
    t.string "review"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "fotos", force: :cascade do |t|
    t.integer "applv_id"
    t.integer "course_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "expense_id"
    t.string "foto_name"
    t.integer "kid_id"
    t.integer "lgbk_id"
    t.integer "parpaym_id"
    t.integer "payment_id"
    t.string "picture"
    t.integer "ptns_mmb_id"
    t.integer "taska_id"
    t.integer "tchdetail_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "kid_bills", force: :cascade do |t|
    t.integer "classroom_id"
    t.float "clsfee"
    t.string "clsname"
    t.datetime "created_at", precision: nil, null: false
    t.text "extra"
    t.text "extradtl"
    t.integer "kid_id"
    t.string "kidic"
    t.string "kidname"
    t.integer "payment_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "kid_extras", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "extra_id"
    t.integer "kid_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "kids", force: :cascade do |t|
    t.string "allergy"
    t.string "alt_phone"
    t.string "arr_infam"
    t.string "birth_place"
    t.string "birthcert"
    t.string "ckn"
    t.integer "classroom_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "date_enter"
    t.date "dob"
    t.string "email"
    t.string "emerctc"
    t.string "father_job"
    t.string "father_job_address"
    t.string "father_name"
    t.string "father_phone"
    t.string "fav_food"
    t.string "fic"
    t.string "fteml"
    t.string "ftgrd"
    t.string "ftosct"
    t.string "ftsct"
    t.string "fulladd"
    t.string "gender"
    t.string "hobby"
    t.string "ic_1"
    t.string "ic_2"
    t.string "ic_3"
    t.string "income"
    t.string "mic"
    t.string "mmeml"
    t.string "mmgrd"
    t.string "mmosct"
    t.string "mmsct"
    t.string "mother_job"
    t.string "mother_job_address"
    t.string "mother_name"
    t.string "mother_phone"
    t.string "name"
    t.string "oku"
    t.string "okuregno"
    t.string "okutype"
    t.string "panel_clinic"
    t.integer "parent_id"
    t.string "pdpa"
    t.string "ph_1"
    t.string "ph_2"
    t.string "prevsc"
    t.string "sib"
    t.string "soku"
    t.string "sph_1"
    t.string "sph_2"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "kidtsks", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "kid_id"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "lgbks", force: :cascade do |t|
    t.text "admid"
    t.string "aktb"
    t.text "aktl"
    t.text "aktp"
    t.text "bi"
    t.text "bm"
    t.text "cin"
    t.text "cout"
    t.datetime "created_at", precision: nil, null: false
    t.text "ctm"
    t.text "gigi"
    t.string "incd"
    t.integer "kid_id"
    t.text "lmpn"
    t.string "mand"
    t.text "medc"
    t.text "mkn"
    t.text "mnd"
    t.text "mt"
    t.string "nmaktdk"
    t.string "nmaktdk1"
    t.string "nmaktdk2"
    t.string "nmaktdk3"
    t.string "nmaktdk4"
    t.string "othdc"
    t.string "phyc"
    t.text "pi"
    t.string "rfpltdk"
    t.string "sbb"
    t.string "sih"
    t.text "susu"
    t.string "susudc"
    t.integer "taska_id"
    t.text "tchid"
    t.string "tdo"
    t.text "tdur"
    t.text "temp"
    t.text "tool"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "otkids", force: :cascade do |t|
    t.float "amt"
    t.datetime "created_at", precision: nil, null: false
    t.string "descotk"
    t.integer "kid_id"
    t.integer "payment_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "owner_colleges", force: :cascade do |t|
    t.integer "college_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "owner_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "owners", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
    t.index ["username"], name: "index_owners_on_username", unique: true
  end

  create_table "parents", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.string "tnc"
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
    t.index ["email"], name: "index_parents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_parents_on_reset_password_token", unique: true
    t.index ["username"], name: "index_parents_on_username", unique: true
  end

  create_table "parpayms", force: :cascade do |t|
    t.float "amt"
    t.datetime "created_at", precision: nil, null: false
    t.string "kind"
    t.string "mtd"
    t.integer "payment_id"
    t.date "upd"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "payinfos", force: :cascade do |t|
    t.float "alwnc"
    t.float "amt"
    t.datetime "created_at", precision: nil, null: false
    t.float "epf"
    t.float "epfa"
    t.float "fxddc"
    t.float "neisa"
    t.float "pcb"
    t.float "sip"
    t.float "sipa"
    t.float "socs"
    t.float "socsa"
    t.integer "taska_id"
    t.integer "teacher_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.float "amount"
    t.string "bill_id"
    t.string "bill_id2"
    t.integer "bill_month"
    t.integer "bill_year"
    t.string "cltid"
    t.integer "course_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.string "discdx"
    t.float "discount"
    t.boolean "exs"
    t.boolean "fin"
    t.integer "kid_id"
    t.string "mtd"
    t.string "name"
    t.boolean "paid"
    t.integer "parent_id"
    t.boolean "reminder"
    t.boolean "s2ph"
    t.string "state"
    t.integer "taska_id"
    t.integer "teacher_id"
    t.datetime "updated_at", precision: nil, null: false
    t.text "waba"
  end

  create_table "payslips", force: :cascade do |t|
    t.float "addtn"
    t.float "alwnc"
    t.float "amt"
    t.float "amtepfa"
    t.datetime "created_at", precision: nil, null: false
    t.float "dedc"
    t.string "desc"
    t.string "descdc"
    t.float "epf"
    t.float "epfa"
    t.float "fxddc"
    t.integer "mth"
    t.float "neisa"
    t.integer "notf"
    t.float "pcb"
    t.string "psl_id"
    t.float "sip"
    t.float "sipa"
    t.float "socs"
    t.float "socsa"
    t.integer "taska_id"
    t.integer "teacher_id"
    t.datetime "updated_at", precision: nil, null: false
    t.text "xtra"
    t.integer "year"
  end

  create_table "prntdetails", force: :cascade do |t|
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.datetime "created_at", precision: nil, null: false
    t.string "ic_1"
    t.string "ic_2"
    t.string "ic_3"
    t.string "name"
    t.integer "parent_id"
    t.string "phone_1"
    t.string "phone_2"
    t.string "postcode"
    t.string "states"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "ptns_mmbs", force: :cascade do |t|
    t.string "add1"
    t.string "add2"
    t.string "city"
    t.datetime "created_at", precision: nil, null: false
    t.date "dob"
    t.string "edu"
    t.string "email"
    t.date "expire"
    t.string "ic1"
    t.string "ic2"
    t.string "ic3"
    t.string "icf"
    t.string "mmb"
    t.string "mmbid"
    t.string "name"
    t.string "ph1"
    t.string "ph2"
    t.string "postcode"
    t.string "state"
    t.string "tp"
    t.string "ts_add1"
    t.string "ts_add2"
    t.string "ts_city"
    t.string "ts_job"
    t.string "ts_name"
    t.string "ts_owner"
    t.string "ts_ph1"
    t.string "ts_ph2"
    t.string "ts_postcode"
    t.string "ts_state"
    t.string "ts_status"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "ptnssps", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.string "opp"
    t.string "strgh"
    t.string "thr"
    t.datetime "updated_at", precision: nil, null: false
    t.string "wkns"
  end

  create_table "siblings", force: :cascade do |t|
    t.bigint "beradik_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "kid_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["beradik_id"], name: "index_siblings_on_beradik_id"
    t.index ["kid_id"], name: "index_siblings_on_kid_id"
  end

  create_table "taska_admins", force: :cascade do |t|
    t.integer "admin_id"
    t.boolean "spv"
    t.integer "taska_id"
  end

  create_table "taska_teachers", force: :cascade do |t|
    t.boolean "stat"
    t.integer "taska_id"
    t.integer "teacher_id"
  end

  create_table "taskas", force: :cascade do |t|
    t.string "acc_name"
    t.string "acc_no"
    t.string "address_1"
    t.string "address_2"
    t.string "bank_name"
    t.string "bank_status"
    t.string "billplz_reg"
    t.integer "bldt"
    t.boolean "blgt"
    t.float "booking"
    t.string "city"
    t.string "collection_id"
    t.string "collection_id2"
    t.string "collection_name1"
    t.string "collection_name2"
    t.datetime "created_at", precision: nil, null: false
    t.float "cred"
    t.float "discount"
    t.string "email"
    t.datetime "expire", precision: nil
    t.text "hiscred"
    t.string "linkreg"
    t.string "name"
    t.string "othnm"
    t.string "phone_1"
    t.string "phone_2"
    t.string "plan"
    t.string "postcode"
    t.integer "psldt"
    t.integer "pslm"
    t.float "rato"
    t.integer "remdt"
    t.string "ssm_no"
    t.string "states"
    t.string "subdomain"
    t.string "supervisor"
    t.string "tskvw"
    t.datetime "updated_at", precision: nil, null: false
    t.text "waba"
    t.string "weekend"
    t.index ["subdomain"], name: "index_taskas_on_subdomain", unique: true
  end

  create_table "tchdetail_colleges", force: :cascade do |t|
    t.integer "college_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "tchdetail_id"
    t.string "tp"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tchdetails", force: :cascade do |t|
    t.string "address_1"
    t.string "address_2"
    t.string "aku"
    t.boolean "akun"
    t.string "ands"
    t.string "anis"
    t.string "biloku"
    t.string "category"
    t.string "city"
    t.integer "college_id"
    t.date "cprdt"
    t.string "cprstat"
    t.datetime "created_at", precision: nil, null: false
    t.date "dob"
    t.string "dun"
    t.string "education"
    t.string "email"
    t.datetime "expjkm", precision: nil
    t.string "foodstat"
    t.string "gender"
    t.string "ic_1"
    t.string "ic_2"
    t.string "ic_3"
    t.string "income"
    t.string "jkm"
    t.string "kapstat"
    t.string "marital"
    t.string "name"
    t.string "phone_1"
    t.string "phone_2"
    t.boolean "picst"
    t.string "post"
    t.string "postcode"
    t.date "startwork"
    t.string "stat"
    t.string "states"
    t.integer "teacher_id"
    t.string "ts_address_1"
    t.string "ts_address_2"
    t.string "ts_city"
    t.string "ts_name"
    t.string "ts_owner_name"
    t.string "ts_phone_1"
    t.string "ts_phone_2"
    t.string "ts_postcode"
    t.string "ts_states"
    t.string "ts_tp"
    t.date "typhdt"
    t.date "typhexp"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tchlvs", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.float "day"
    t.string "name"
    t.integer "taska_id"
    t.integer "teacher_id"
    t.integer "tsklv_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "teacher_colleges", force: :cascade do |t|
    t.integer "college_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "teacher_id"
    t.string "tp"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "teacher_courses", force: :cascade do |t|
    t.integer "course_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "teacher_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "confirmation_sent_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.string "tnc"
    t.string "unconfirmed_email"
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
    t.index ["username"], name: "index_teachers_on_username", unique: true
  end

  create_table "teachers_classrooms", force: :cascade do |t|
    t.integer "classroom_id"
    t.integer "teacher_id"
  end

  create_table "tskbills", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.float "disc"
    t.integer "payment_id"
    t.float "real"
    t.float "stp"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tsklvs", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "day"
    t.string "desc"
    t.string "name"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "vltrs", force: :cascade do |t|
    t.string "address"
    t.integer "classroom_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "crs"
    t.string "edu"
    t.string "email"
    t.string "gender"
    t.string "ic"
    t.string "marr"
    t.string "name"
    t.string "ocrs"
    t.string "ph"
    t.integer "taska_id"
    t.datetime "updated_at", precision: nil, null: false
  end
end
