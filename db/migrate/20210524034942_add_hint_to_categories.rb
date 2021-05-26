class AddHintToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :hint, :string
    add_column :categories, :hint_image, :string
    add_column :categories, :hint_audio, :string
  end
end
