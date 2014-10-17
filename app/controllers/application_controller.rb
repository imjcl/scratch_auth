class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :is_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    unless logged_in?
      redirect_to log_in_path
    end
  end

  def is_admin?
    current_user.role_id == 'Administrator'
  end  

  def require_admin
    unless is_admin?
      redirect_to log_in_path
    end
  end

  def is_me?
    current_user.id.to_s == params[:id]
  end

  def require_privilege
    unless is_me? || is_admin?
      redirect_to users_path
    end
  end

end
