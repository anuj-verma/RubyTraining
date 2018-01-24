class RemoveUseridFromPost < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :user_id_id, :integer
  end
end
