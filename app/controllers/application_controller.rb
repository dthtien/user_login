class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized


  protected
    def authenticate_user!
      unless logged_in?
        flash[:alert] = "You have to login first"
        redirect_to log_in_path
      end
    end

    def not_authorized
      redirect_to root_path, alert: "You have no permission"
    end
end
