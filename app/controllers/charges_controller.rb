class ChargesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery :except => :webhook

  # def webhook
  #   # Put logic to verify monthly subscription transactions are successful
  # end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      plan: {
        premium_plan1: "Premium",
        premium_plan1_info: "data-description='Premium Plan - $9.99/Month'"
      },
      description: "Big Super Premium Membership - #{current_user.name}",
    }
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)

    customer.subscriptions.retrieve(current_user.subscription_id).delete
    current_user.update_attributes(role: 'standard', subscription_id: nil)
    flash[:notice] = "Your Subscription Has Been Successfully Cancelled"
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to user_path(current_user)
  end

  def create
    # Creates a Stripe Customer Object to associate with charge, pass plan params for subscriptions
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken],
    plan: params[:plan]
    )

    # Used for 1-time charges
    # charge = Stripe::Charge.create(
    #   customer: customer.id, #NOT in-app user_id
    #   amount: Amount.default,
    #   decription: "Big Money Membership - #{current_user.email}",
    #   currency: 'usd'
    # )

    flash[:notice] = "Thanks for sending me that sweet, sweet dough #{current_user.name}!"
    current_user.update_attributes(role: 'premium', stripe_id: customer.id, subscription_id: customer.subscription.id)
    redirect_to user_path(current_user)

    # Rescue block for Stripe card errors
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
