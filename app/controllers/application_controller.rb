class ApplicationController < ActionController::Base

  private 
  helper_method :current_user
  def current_user
    user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user?
  def current_user?(user)
    current_user == user
  end

  helper_method :require_signin
  def require_signin
    if !current_user
      flash[:alert] = 'Please sign in to continue!'
      session[:intended_route] = request.url
      redirect_to signin_path
    end
  end

  helper_method :require_admin
  def require_admin
    if !current_user.admin? 
      redirect_to events_url, alert: 'Unauthorized Access!'
    end
  end

  helper_method :current_user_admin?
  def current_user_admin?
    current_user && current_user.admin? 
  end
end
