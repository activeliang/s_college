class CreatePhoneTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :phone_tokens do |t|
      t.string :token
      t.string :phone
      t.datetime :expired_at
      t.timestamps
    end

    add_index :phone_tokens, [:phone, :token]
  end
end
