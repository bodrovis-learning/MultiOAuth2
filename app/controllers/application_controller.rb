class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to root_path unless user_signed_in?
  end

  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def user_signed_in?
    !@current_user.nil?
  end

  def current_user
    # We either return a previously set @current_user variable or
    # set it to a guest user
    @current_user ||= GuestUser.new
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
