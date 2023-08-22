# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages, id: :uuid do |t|
      t.string  :code
      t.string  :name_km
      t.string  :name_en
      t.uuid    :parent_id
      t.integer :visits_count

      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      # optional fields
      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.timestamps
    end
  end
end
