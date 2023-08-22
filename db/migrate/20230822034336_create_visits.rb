# frozen_string_literal: true

class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits, id: :uuid do |t|
      t.string :page_id
      t.string :pageable_id
      t.string :pageable_type
      t.integer :user_id
      t.string :device_id
      t.datetime :visit_date

      t.timestamps
    end
  end
end
