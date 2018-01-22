class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :gender
      t.datetime :date_of_birth
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
