# frozen_string_literal: true

class CreateForms < ActiveRecord::Migration[6.0]
  def change
    create_table :forms do |t|
      t.string   :uuid
      t.string   :name
      t.string   :form_type
      t.integer  :version

      t.timestamps
    end
  end
end
