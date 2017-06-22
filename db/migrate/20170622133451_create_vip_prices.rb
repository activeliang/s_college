class CreateVipPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :vip_prices do |t|
      t.string :title
      t.decimal :price,       precision: 10, scale: 2
      t.integer :weight
      t.boolean :is_hidden, default: true
      t.timestamps
    end
  end
end
