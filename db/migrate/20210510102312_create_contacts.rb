class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :country, null: false, foreign_key: true
      t.references :help_center, null: false, foreign_key: true
      t.string :phones, array: true, default: []

      t.timestamps
    end
  end
end
