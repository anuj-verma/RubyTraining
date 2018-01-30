class AddressesController < ApplicationController
	def index
		@users = User.all
		@u = @users.find_by(id: params[:user_id])
		@address = Address.find_by(user_id: params[:user_id])
	end

	def show
		@address = Address.find_by(user_id: params[:user_id])
	end

	def new
		@address =Address.new
		@user = User.find(params[:user_id])
	end

	def create
      @address =Address.new(address_params)
      @user = User.find_by(id: params[:user_id])
	  @user.address = @address
	  redirect_to user_addresses_path(@user)
		#render 'index'
	end

	def update
  	  @address = Address.find(params[:user_id])
      if @address.update(address_params)
      	redirect_to users_path
      else
        render 'edit'
      end
    end

  	def edit
  	  @address = Address.find_by(user_id: params[:user_id])
  	end

  	def destroy
  	  Address.find_by(user_id: params[:user_id]).destroy
  	  redirect_to users_path
  	end

  	private
  	def address_params
  	  params.require(:address).permit(:city, :state, :country, :user_id)
  	end
  end