class AddColumnContactPhoneToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :contact_phone, :string
  end
end
