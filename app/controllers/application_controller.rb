class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  #layout :which_layout

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def which_layout
    if browser.mobile?
      'mobile'
    else
      'application'
    end
  end

  def logged_in?
    return true if current_user
    nil
  end

  helper_method :current_user
end
