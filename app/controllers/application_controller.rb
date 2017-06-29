class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  include SessionsHelper

  protected
    def authenticate_user!
      unless logged_in?
        flash[:alert] = "You have to login first"
        redirect_to log_in_path
      end
    end
end
