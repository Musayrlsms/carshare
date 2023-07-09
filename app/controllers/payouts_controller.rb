class PayoutsController < ApplicationController
  def index
    @payouts = Payout.all
  end

  def new
    payout = Stripe::Payout.create({
      amount: params[:amount],
      currency: 'eur',
    })
    
    Payout.create!(
      message: '',
      amount: params[:amount],
      stripe_id: payout['id'],
      status: 1,
      response: payout
    )
    
    redirect_to balance_profiles_path, message: 'Your payout created. It will be approved in 24 hours'
  end

  def update
    @payout = Payout.find(id: params[:id])

    Stripe::Payout.retrieve(
      @payout.stripe_id
    )
  end
end
