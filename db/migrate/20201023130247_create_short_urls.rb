# frozen_string_literal: true

class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.string :uuid, null: false, comment: 'Unique URL Id'
      t.integer :access_count, default: 0, null: false, comment: 'Number of the URL requested'
      t.string :original_url, null: false, comment: 'Original URL'
      t.index :uuid, unique: true

      t.timestamps
    end
  end
end
