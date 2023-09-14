# frozen_string_literal: true

class AddDashboardAccessibleToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :dashboard_accessible, :boolean, default: false
  end
end
