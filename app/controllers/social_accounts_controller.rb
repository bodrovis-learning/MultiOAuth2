class SocialAccountsController < ApplicationController
  # We have to check the owner. If the requested account does not belong to the
  # currently logged in user, do nothing.
  before_action :check_owner!, only: [:destroy]

  def create
    @social_account = SocialAccount.from_omniauth(request.env['omniauth.auth'], current_user)
    sign_in @social_account.user
    redirect_to root_path
  end

  def destroy
    @social_account.destroy
    redirect_to root_path
  end

  private

  def check_owner!
    @social_account = SocialAccount.find(params[:id])
    redirect_to root_path unless current_user.social_accounts.include?(@social_account)
  end
end