class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :image_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
