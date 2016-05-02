class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new

  end

  def create
    @user = User.find_by(params[:email])
    if @user # && ?
      redirect_to root_path
    else
      flash.now[:error] = "Login and/or password is incorrect."
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "See you!"
    redirect_to new_user_path
  end
end