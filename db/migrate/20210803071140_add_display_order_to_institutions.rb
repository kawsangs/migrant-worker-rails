# frozen_string_literal: true

class AddDisplayOrderToInstitutions < ActiveRecord::Migration[6.0]
  def up
    add_column :institutions, :display_order, :integer

    Rake::Task["institution:migrate_display_order"].invoke
  end

  def down
    remove_column :institutions, :display_order
  end
end
