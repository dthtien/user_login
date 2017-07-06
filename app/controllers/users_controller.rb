class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :index]
  before_action :set_friend, except: [:new, :create, :index]

  def index
    @users = User.includes(:profile).all
  end

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

  def friend_request
    current_user.friend_request @friend
    respond_to do |format|
      format.html{
        redirect_to root_path, notice: "Your request was sent "
      }
      format.js
    end
  end

  def accept_request
    current_user.accept_request @friend
    respond_to do |format|
      format.html{
        redirect_to root_path, notice: "You and #{@friend.full_name} are in friendship"
      }
      format.js
    end
  end

  def decline_request
    current_user.decline_request @friend
    respond_to do |format|
      format.html{
        redirect_to root_path, notice: "You and #{@friend.full_name} are not in friendship"
      }
      format.js
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def set_friend
      @friend = User.find(params[:id])
    end
end
