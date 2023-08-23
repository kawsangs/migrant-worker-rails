# frozen_string_literal: true

class ChangeColumnTaggableIdInTaggings < ActiveRecord::Migration[6.1]
  def change
    change_column :taggings, :taggable_id, :string
  end
end
