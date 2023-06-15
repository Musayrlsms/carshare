class BankAccountsController < ApplicationController
  def new
    unless current_user.stripe_account
      redirect_to new_stripe_account_path_wefwefwfw and return
    end

    @account = Stripe::Account.retrieve(current_user.stripe_account.account_id)
  end

  def create
    unless params[:stripeToken] && current_user.stripe_account&.account_id
      redirect_to new_bank_account_path and return
    end

    account = Stripe::Account.retrieve(current_user.stripe_account.account_id)

    account.external_account = params[:stripeToken]
    account.save
    
    flash[:success] = "Your bank account has been added!"
    redirect_to dashboard_path
  end
end
