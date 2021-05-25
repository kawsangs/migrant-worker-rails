class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :type, null: false
      t.string :value, default: ''
      t.references :institution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
