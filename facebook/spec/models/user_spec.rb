require 'rails_helper'
RSpec.describe User do |variable|
  let(:user1) {build :user}
  let(:user2) {build :user, gender: 'male'}
  let(:user3) {build :user, date_of_birth: '20-01-2020' }
  let(:user4) {build :user, date_of_birth: '20-01-1995' }
  it '' do
	 #user = User.create(name: 'jyoti',email: 'jyoti@gmail.com', gender: 'female')
	  r = user2.is_female?
    expect(r).to eq(false)
  end

  it '' do
  #user = User.create(name: 'jyoti',email: 'jyoti@gmail.com', gender: 'female')
    r = user1.is_female?
    expect(r).to eq(true)
  end

  it '' do
    #user = User.create(name: 'jyoti',email: 'jyoti@gmail.com', date_of_birth: '20-01-1993', password: '1234567', gender: 'female')
	  result = user1.valid?
	  expect(result).to eq(true)
  end

  it '' do
 	  #user = User.create(name: 'jyoti',email: 'jyoti@gmail.com', gender: 'female', date_of_birth: '20-01-2019', password: '1234567')
	  result = user3.is_valid_date?
	  expect(result).to eq(false)
  end
  
  it '' do
 	  #user = User.create(name: 'jyoti',email: 'jyoti@gmail.com', gender: 'female', date_of_birth: '20-01-1997', password: '1234567')
	  result = user4.is_valid_date?
	  expect(result).to eq(true)
  end

end