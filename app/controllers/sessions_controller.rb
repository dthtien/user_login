class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "Heloo #{user.full_name}"
      redirect_to user.edit_profile? ? edit_profile_path(user.profile) : root_path
    else
      flash.now[:alert] = "Please check your email and password"
      render :new
    end
  end

  def destroy
    log_out
    flash[:notice] = "Goodbye!"
    redirect_to root_path
  end
end
