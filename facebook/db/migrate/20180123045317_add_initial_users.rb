class AddInitialUsers < ActiveRecord::Migration[5.1]
  def up
      User.create!(name: "Jyoti Sharma", gender: "Female", email: "jyoti@gmail.com", password: "12345", date_of_birth: "28-01-1996") 
      User.create!(name: "Pooja Sharma", gender: "Female", email: "pooja@gmail.com", password: "12345", date_of_birth: "22-02-1996")
      User.create!(name: "Ram", gender: "Male", email: "ram@gmail.com", password: "12345", date_of_birth: "15-03-1996")
      User.create!(name: "Karan", gender: "Male", email: "karan@gmail.com", password: "12345", date_of_birth: "18-04-1996")
      User.create!(name: "Arjun", gender: "Male", email: "arjun@gmail.com", password: "12345", date_of_birth: "8-05-1996")
  end

  def down
    User.delete_all
  end
end
