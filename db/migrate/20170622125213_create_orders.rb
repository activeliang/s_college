class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :price,       precision: 10, scale: 2
      t.integer :user_id, :payment_id
      t.string :token
      t.boolean :is_paid, default: false
      t.datetime :payment_at
      t.timestamps
    end
  end
end
