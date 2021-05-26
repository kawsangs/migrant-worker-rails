class AddIsVideoToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :is_video, :boolean
  end
end
