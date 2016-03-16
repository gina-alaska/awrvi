class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |_exception|
    if signed_in?
      flash[:error] = 'You do not have permission to view this page'
      redirect_to session[:referred_from_url] || request.referer || root_url
    else
      save_current_location
      redirect_to user_omniauth_authorize_path(:open_id, openid_url: 'https://id.gina.alaska.edu')
    end
  end

  protected

  def save_current_location
    session[:referred_from_url] = request.referer
    store_location_for(current_user || User.new, request.original_url)
  end

  def save_referrer_location
    store_location_for(current_user || User.new, request.referer)
  end
end
