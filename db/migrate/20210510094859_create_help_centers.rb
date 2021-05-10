class CreateHelpCenters < ActiveRecord::Migration[6.0]
  def change
    create_table :help_centers do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
