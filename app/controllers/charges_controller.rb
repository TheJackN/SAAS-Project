class ChargesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery :except => :webhook

  # def webhook
  #   # Put logic to verify monthly subscription transactions are successful
  # end

  def new
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

    current_user.update_attributes(role: 'standard', subscription_id: nil)
    current_user.wikis.update_all(private: false)

    flash[:notice] = "Your Subscription Has Been Successfully Cancelled"
    redirect_to user_path(current_user)

  rescue Stripe::StripeError => e
    flash[:error] = e.message
    redirect_to user_path(current_user)
  end

  def create
    @user = current_user
    if current_user.stripe_id == nil
      customer = Stripe::Customer.create(
      plan: "premium_plan1",
      email: current_user.email,
      card: params[:stripeToken]
      )
      current_user.update_attributes(role: 'premium', stripe_id: customer.id, subscription_id: customer.subscriptions.data.first.id)
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.subscriptions.create(plan: "premium_plan1")
      current_user.update_attributes(role: 'premium', subscription_id: customer.subscriptions.first.id)
    end
    puts "*" * 20
    puts customer.subscriptions.inspect
    flash[:notice] = "Thanks for sending me that sweet, sweet dough #{current_user.name}!"
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end
end
