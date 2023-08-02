# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos, id: :uuid do |t|
      t.string :name
      t.text   :description
      t.string :url
      t.integer :display_order
      t.uuid :video_author_id

      t.timestamps
    end
  end
end
