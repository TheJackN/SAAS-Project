class ChargesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery :except => :webhook

  # def webhook
  #   # Put logic to verify monthly subscription transactions are successful
  # end

  def new
    #This needs fixing
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      plan: "premium_plan1",
      description: "Big Super Premium Membership - #{current_user.name}",
    }
  end

  def destroy
    @user = current_user
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.subscription_id).delete

    private_wikis = current_user.wikis.where(private: true)

    unless private_wikis.nil? || private_wikis = []
      private_wikis.update_attributes(private: false)
    end

    current_user.update_attributes(role: 'standard', subscription_id: nil)

    flash[:notice] = "Your Subscription Has Been Successfully Cancelled"
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to user_path(current_user)
  end

  def create
    @user = current_user
    if current_user.stripe_id == nil
      customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )
      
      customer.subscriptions.create(plan: "premium_plan1")

      current_user.update_attributes(role: 'premium', stripe_id: customer.id, subscription_id: customer.subscriptions.first.id)
      flash[:notice] = "Thanks for sending me that sweet, sweet dough #{current_user.name}!"
      redirect_to user_path(current_user)

    else
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.subscriptions.create(plan: "premium_plan1")

      current_user.update_attributes(role: 'premium', subscription_id: customer.subscriptions.first.id)
      flash[:notice] = "Thanks for sending me that sweet, sweet dough again #{current_user.name}!"
      redirect_to user_path(current_user)
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

    # Used for 1-time charges
    # charge = Stripe::Charge.create(
    #   customer: customer.id, #NOT in-app user_id
    #   amount: Amount.default,
    #   decription: "Big Money Membership - #{current_user.email}",
    #   currency: 'usd'
    # )
  end
end
