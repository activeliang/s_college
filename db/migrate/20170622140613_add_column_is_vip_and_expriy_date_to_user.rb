class AddColumnIsVipAndExpriyDateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_vip, :boolean, default: false
    add_column :users, :expriy_date, :datetime
  end
end
