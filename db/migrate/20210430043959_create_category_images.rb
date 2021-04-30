class CreateCategoryImages < ActiveRecord::Migration[6.0]
  def change
    create_table :category_images do |t|
      t.string  :name
      t.string  :image
      t.string  :category_uuid
      t.integer :category_id

      t.timestamps
    end
  end
end
