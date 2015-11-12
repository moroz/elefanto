module LoggedIn
  extend ActiveSupport::Concern

  def logged_in?
    return true if current_user
    nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def only_authorized(redirecting_to = root_path)
    # this method checks if the user is logged in, if not, it redirects to redirecting_to
    if logged_in?
      return true
    else
      logger.error "Attempt to access #{request.fullpath} by an unauthorized person, from #{request.remote_ip}."
      flash[:danger] = "You are not allowed to perform this action."
      redirect_to redirecting_to
      return false
    end
  end
end
