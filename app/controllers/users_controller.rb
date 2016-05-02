class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  # Users cannot modify profiles they do not own
  before_action :check_owner!, only: [:edit, :update]

  def edit
    @providers = SocialAccount::AVAILABLE_PROVIDERS
  end

  def update
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome!"
      sign_in @user
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def check_owner!
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
  end
end