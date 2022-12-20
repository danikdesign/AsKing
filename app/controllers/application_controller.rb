class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success

  include Pagy::Backend
  include ErrorHandling
  include UserAuthorization

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :current_user
  helper_method :user_signed_in?

end
