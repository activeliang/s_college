class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :title, :subtitle, :main_image, :minor_image
      t.boolean :is_free, default: false
      t.integer :category_id, :weight
      t.text :intro, :description
      t.timestamps
    end
  end
end
