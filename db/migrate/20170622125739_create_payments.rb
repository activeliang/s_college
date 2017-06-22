class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.string :payment_no, :transaction_no
      t.boolean :is_paid, default: false
      t.decimal :price,       precision: 10, scale: 2
      t.datetime :payment_at
      t.text :raw_response
      t.timestamps
    end
  end
end
