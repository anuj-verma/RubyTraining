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

	validates :name, presence: true
	validates :gender, presence: true
	validates :email, presence: true
	validates :password, presence: true, confirmation: true
	has_one :address
	has_many :posts
end
