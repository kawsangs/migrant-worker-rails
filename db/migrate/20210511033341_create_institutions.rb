# frozen_string_literal: true

class CreateInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :institutions do |t|
      t.string :name, null: false, index: true
      t.integer :kind, default: 2, comment: "ex: ngo, gov. agency, other (default)"
      t.text :address, default: ""
      t.string :logo
      t.string :audio

      t.timestamps
    end
  end
end
