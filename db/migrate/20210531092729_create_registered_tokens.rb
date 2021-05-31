class CreateRegisteredTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_tokens do |t|
      t.string   :token

      t.timestamps
    end
  end
end
