# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  country    :string
#  state      :string
#  city       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  userid     :string
#

class Address < ApplicationRecord
	belongs_to :user
	validates :state, :city, :country, presence: true
end
