class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  helper_method :current_user, :count_words, "logged_in?", :post_number, 'mobile?', 'desktop?'

  # before_action do
  #   resource = controller_name.singularize.to_sym
  #   method = "#{resource}_params"
  #   params[resource] &&= send(method) if respond_to?(method, true)
  # end

  def set_locale
    session[:locale] = params[:lang] if params[:lang]
    I18n.locale = session[:locale] || extract_locale_from_http_header || I18n.default_locale
  end

  def count_words(string, chinese)
    unless chinese
      strip_tags(string).split.length
    else
      strip_tags(string).split('').length
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def post_number(number)
    return "" if number.nil? || number == 0
    if number == number.floor
      return "%d. " % number
    else
      return (("%.1f. " % number).sub('.', ','))
    end
  end
  
  def mobile?
    browser.device.mobile? || browser.device.tablet?
  end
  
  def desktop?
    !mobile?
  end

  private

  def extract_locale_from_http_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
    I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def only_authorized(redirecting_to = root_path)
    return true if logged_in?
    logger.error "Attempt to access #{request.fullpath} by an unauthorized person, from #{request.remote_ip}."
    flash[:danger] = "You are not allowed to perform this action."
    redirect_to redirecting_to
  end
end
