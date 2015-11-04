class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :load_user

  def show
  end


  private

  def load_user
    if current_user == nil
      flash[:error] = "You must be logged in to do that"
      redirect_to new_user_registration_path
    else
      @user = User.find(params[:id])
      authorize @user
    end
  end
end
