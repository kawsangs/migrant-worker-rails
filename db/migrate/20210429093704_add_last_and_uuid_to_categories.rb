# frozen_string_literal: true

class AddLastAndUuidToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :last, :boolean, default: false
    add_column :categories, :uuid, :string
  end
end
