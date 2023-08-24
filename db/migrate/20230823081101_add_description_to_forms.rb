# frozen_string_literal: true

class AddDescriptionToForms < ActiveRecord::Migration[6.1]
  def change
    add_column :forms, :description, :text
  end
end
