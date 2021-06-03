# frozen_string_literal: true

class AddCodeToInstitutions < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :code, :string
  end
end
