require 'rails_helper.rb'
RSpec.describe UsersController do

  it '' do
    get :index
    expect(response.status).to eq(200)
    assert_template 'users/index'
  end

  let!(:user) { User.create(name: 'varsha') }

  it '' do
    get :index, format: :json
    #binding.pry
    expect(response.status).to eq(200)
    expect(response.content_type).to eq('application/json')
    expect(JSON.parse(response.body).size).to eq(1)
  end

  it '' do
    post :create, params: { user: { name: 'josh' }}, format: :json
    expect(response.status).to eq(201)
    expect(response.content_type).to eq('application/json')
    result = JSON.parse(response.body)
    expected_user = User.last
    expect(result['id']).to eq(expected_user.id)
  end
end