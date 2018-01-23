class AddUserIdToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :userid, :string
  end
end
