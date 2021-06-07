# frozen_string_literal: true

class AddNameKmToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :name_km, :string
  end
end
