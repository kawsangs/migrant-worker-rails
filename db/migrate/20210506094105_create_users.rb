# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :uuid
      t.string  :full_name
      t.string  :sex
      t.string  :age
      t.string  :audio
      t.datetime :registered_at

      t.timestamps
    end
  end
end
