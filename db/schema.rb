# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_201_023_130_247) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'short_urls', force: :cascade do |t|
    t.string 'uuid', null: false, comment: 'Unique URL Id'
    t.integer 'access_count', default: 0, null: false, comment: 'Number of the URL requested'
    t.string 'original_url', null: false, comment: 'Original URL'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['uuid'], name: 'index_short_urls_on_uuid', unique: true
  end
end
