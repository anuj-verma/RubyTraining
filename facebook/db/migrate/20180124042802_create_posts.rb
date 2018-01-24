class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.integer :no_of_likes
      t.belongs_to :user_id, foreign_key: true

      t.timestamps
    end
  end
end
