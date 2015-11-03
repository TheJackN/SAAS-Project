class ChargesController < ApplicationController
  protect_from_forgery :except => :webhook

# Need to create Amount class with default class method to return charge amount in pennies 

  def webhook
    # Process webhook data in `params`
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Big Money Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

  def create
    # Creates a Stripe Customer Object to associate with charge
    customer: Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    # Apparently where the magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, #NOT in-app user_id
      amount: Amount.default,
      decription: "Big Money Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for sending me that sweet, sweet dough #{current_user.name}!"
    redirect_to user_path(current_user)

    # Rescue block for Stripe card errors
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
