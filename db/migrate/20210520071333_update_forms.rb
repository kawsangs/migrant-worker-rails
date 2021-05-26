class UpdateForms < ActiveRecord::Migration[6.0]
  def change
    rename_column :forms, :uuid, :code
    add_column :forms, :image, :string
    add_column :forms, :audio, :string
  end
end
