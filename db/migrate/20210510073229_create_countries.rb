# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :code, default: ""

      t.timestamps
    end
  end
end
