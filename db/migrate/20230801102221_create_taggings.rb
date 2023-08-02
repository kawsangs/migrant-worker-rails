# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.uuid :tag_id
      t.uuid :taggable_id
      t.string :taggable_type

      t.timestamps
    end
  end
end
