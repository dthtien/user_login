class UsersController < ApplicationController
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      @user.send_welcome_email
      log_in(@user)
      flash[:notice] = "Welcome #{@user.full_name}. Please update your information"
      redirect_to edit_profile_path @user.profile
    else
      flash.now[:alert] = "Error!"
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
