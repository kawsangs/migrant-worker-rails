# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections, id: :uuid do |t|
      t.string   :name
      t.integer  :form_id
      t.integer  :display_order

      t.timestamps
    end
  end
end
