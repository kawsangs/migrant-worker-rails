class CreateCriteria < ActiveRecord::Migration[6.0]
  def change
    create_table :criteria do |t|
      t.integer :question_id
      t.string  :question_code
      t.string  :operator
      t.string  :response_value

      t.timestamps
    end
  end
end
