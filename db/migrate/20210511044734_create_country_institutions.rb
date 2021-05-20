class CreateCountryInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :country_institutions do |t|
      t.string :country_name, null: false
      t.references :institution, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
