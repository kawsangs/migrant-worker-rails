# frozen_string_literal: true

class CreateMigrants < ActiveRecord::Migration[6.0]
  def change
    create_table :migrants do |t|
      t.string  :full_name
      t.string  :age
      t.string  :sex
      t.string  :phone_number
      t.string  :voice
      t.string  :uuid

      t.timestamps
    end
  end
end
