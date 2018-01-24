class RemoveUseridFromAdrress < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :userid, :integer
  end
end
