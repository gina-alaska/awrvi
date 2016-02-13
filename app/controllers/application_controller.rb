class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :search_params
  check_authorization

  private

  def search_params
    params.permit(:q)
  end
end
