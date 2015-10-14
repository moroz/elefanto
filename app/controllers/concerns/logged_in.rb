module LoggedIn
  extend ActiveSupport::Concern

  def logged_in?
    return true if current_user
    nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
