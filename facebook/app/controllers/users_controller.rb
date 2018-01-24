class UsersController < ApplicationController
	include UsersHelper
  def index
  	@users =User.all
  #	@mydate = format_time(Time.now) #helper methods can be accessed in views not in controller
  end
  
  def show
  	@user =User.find_by(params[:id])
  end
  
  def new
  	@user =User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		flash[:success] = "User successfully added"
  		redirect_to users_path
  	else
  		flash[:error] = "User not created"
  		render :new
  	end
  end

  def update
  	@user = User.update(user_params)
  		  	if @user.save
  		flash[:success] = "User successfully updated"
  		redirect_to @user_path
  	else
  		flash[:error] = "User not updated"
  		render :edit
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def destroy
  	User.find(params[:id]).destroy
  	redirect_to users_path
  end

  private
  def user_params
  	params.require(:user).permit(:name, :gender, :email, :password, :password_confirmation, :date_of_birth )
  end
end
