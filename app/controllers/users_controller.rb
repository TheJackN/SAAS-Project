class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :load_user

  def show
  end

  def upgrade
    # Run charges controller for Strip
    # If recieve ok from stripe
    # Then upgrade user from standard to premium
    # Else
    # raise error and render user profile page

  end

  def downgrade
    # if user user role is premium and chooses to downgrade account
    # cancel stripe account and downgrade role to standard
    # render user profile page
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
