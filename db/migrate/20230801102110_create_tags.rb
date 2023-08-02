# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :name
      t.integer :taggings_count
      t.integer :display_order

      t.timestamps
    end
  end
end
