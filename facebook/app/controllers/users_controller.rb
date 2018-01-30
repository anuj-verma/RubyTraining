class UsersController < ApplicationController
	# include UsersHelper
  
  def index
  	@users =User.all
      #	@mydate = format_time(Time.now) #helper methods can be accessed in views not in controller
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @users.to_xml }
      format.json { render json: @users }
    end

  end
  
  def new
  	@user =User.new
  end
  
  def show
  	@user =User.find_by(params[:id])
  end

  def create
  	@user = User.new(user_params)
    if @user.save
  		redirect_to users_path
  	else
  		render :new
  	end
  end

  def update
  	 @user = User.find(params[:id])
 
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
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
