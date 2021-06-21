class AddNameKmToInstitutions < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :name_km, :string
  end
end
