class BankAccountsController < ApplicationController
  def new
    unless current_user.stripe_account
      redirect_to new_stripe_account_path_wefwefwfw and return
    end

    @account = Stripe::Account.retrieve(current_user.stripe_account.account_id)
  end

  def create
    unless params[:stripeToken] && current_user.stripe_account&.account_id
      redirect_to bank_accounts_profiles_path and return
    end

    account = Stripe::Account.retrieve(current_user.stripe_account.account_id)

    account.external_account = params[:stripeToken]
    response = account.save
    
    bank_account = BankAccount.create!(response: response, user: current_user, iban: params[:iban])
    current_user.bank_account = bank_account
    current_user.save!

    flash[:success] = "Your bank account has been added!"
    redirect_to bank_accounts_profiles_path
  end

  def destroy
    stripe_account = current_user.stripe_account
    if true
      flash[:success] = "Your bank account has been deleted!"
      redirect_to bank_accounts_profiles_path
    else
      flash[:error] = "An error accured when deleting your bank account"
      redirect_to bank_accounts_profiles_path
    end
  end
end
