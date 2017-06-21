class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :lesson_id, :chapter_id
      t.integer :weight
      t.timestamps
    end
  end
end
