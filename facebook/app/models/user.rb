# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string
#  gender        :string
#  date_of_birth :datetime
#  email         :string
#  password      :string
#

class User < ApplicationRecord

	validates :name, presence: true, format: { with: /\A[a-zA-Z ]+\z/, message: 'Invalid' }
	validates :gender, presence: true, inclusion: {in: ['male','female']}
	validates :email, presence: true,  format: { with: /\A[a-zA-Z]+\w*@\w+[.][a-z]{3}\z/, message: 'Invalid email'} 
	validates :password, presence: true, confirmation: true, length: { minimum: 6}
	validates :date_of_birth, presence: true
	has_one :address
	has_many :posts

	def is_female?
	  gender == 'female'
	end

	def is_valid_date?
	   date_of_birth < Time.now.strftime("%d-%m-%Y")
	end
end
