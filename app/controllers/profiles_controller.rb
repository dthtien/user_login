class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_profile

  def show
    @posts = @profile.posts.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    authorize @profile
  end

  def update
    authorize @profile

    if @profile.update(profile_params)
      flash[:notice] = "Profile was updated"
      redirect_to @profile
    else
      flash.now[:alert] = "Could not update your profile"
      render :edit
    end
  end

  private
    def set_profile
      @profile = Profile.includes(:user).find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:address, :birthday)
    end
end
