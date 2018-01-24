# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  text        :string
#  no_of_likes :integer
#  user_id_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user
  validates :title, :text, :no_of_likes, presence: true

end
