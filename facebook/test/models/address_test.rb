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

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
