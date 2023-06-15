class SandboxController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if current_user.stripe_account
      jfegfjewh
    else
      stripe_account = Stripe::Account.create(
        type: 'custom',
        country: 'HR',
        capabilities: {
          card_payments: {requested: true},
          transfers: {requested: true},
        }, 
        business_type: 'individual',
        individual: {
          first_name: "Alperen",
          last_name: "BOZKURT 2",
          dob: {
            day: "24",
            month: "09",
            year: "1997",
          },
          address: {
            line1: "lalor",
            postal_code: "3075",
            city: "Melbourne"
          },
          email: 'mail@alperenbozkurt.net',
          phone: "+61479168309"
        },
        business_profile: {
          product_description: 'Fundraising campaign',
          mcc: '5818'
        },
        tos_acceptance: {
          date: Time.now.to_i,
          ip: request.remote_ip
        }
      )
      stripe_account = StripeAccount.new(account_id: stripe_account.id, user_id: current_user.id)
      if stripe_account.save
        redirect_to new_bank_account_path
      else
        error
      end
    end
  end

  def new

  end

  def create
    customer = Stripe::Customer.create({
      email: 'salim.tambay@gmail.com',
      name: 'salim tambay',
    })
    
    token = Stripe::Token.create({
      card: {
        number:     '4242424242424242',
        exp_month:  '12',
        exp_year:   '24',
        cvc:        '345'
      }
    })

    credit_card = CreditCard.new(
      stripe_credit_card_id: token['card']['id'], 
      last_four_digits: '4242', 
      user: current_user,
    )

    transfer_group = "order-#{current_user.id}-mahmut-#{Time.current}" 

    pm = Stripe::PaymentMethod.create({
      type: 'card',
      card: {
        number: '4242424242424242',
        exp_month: 8,
        exp_year: 2024,
        cvc: '314',
      },
    })

    pm_attach = Stripe::PaymentMethod.attach(
      pm['id'],
      { customer: customer['id'] }
    )


    payment_intent = Stripe::PaymentIntent.create({
      amount: amount,
      currency: data['currency'],
      application_fee_amount: calculate_application_fee_amount(amount),
      automatic_payment_methods: {enabled: true},
      transfer_data: {
        destination: data['account'],
      },
      on_behalf_of: User.first.stripe_account.account_id
    })


    wefwefewfwe 
    ewfwefwe

    response = {
      'publishableKey': ENV['STRIPE_PUBLISHABLE_KEY'],
      'clientSecret': payment_intent.client_secret
    }
  end

  def rent
    @stripe_account = Stripe::Account.retrieve(User.first.stripe_account.account_id)

    # Get the payout details
    @payout = Stripe::Payout.retrieve(
      {
        id: params[:id]
      },
      { stripe_account: current_user.stripe_account.account_id }
    )

    # Get the balance transactions from the payout
    @txns = Stripe::BalanceTransaction.list(
      {
        payout: params[:id],
        expand: ['data.source.source_transfer', 'data.source.charge.source_transfer'],
        limit: 100
      },
      { stripe_account: current_user.stripe_account.account_id }
    )
    regergerg
  end

  def create_payment_intent
    data = JSON.parse(request.body.read)
    amount = calculate_order_amount(data['items'])
  
    payment_intent = Stripe::PaymentIntent.create({
      amount: amount,
      currency: 'eur',
      application_fee_amount: calculate_application_fee_amount(amount),
      automatic_payment_methods: {enabled: true},
      transfer_data: {
        destination: User.first.stripe_account.account_id,
      },
      on_behalf_of: User.first.stripe_account.account_id
    })
  
    render json: {
      'publishableKey': ENV['STRIPE_PUBLISHABLE_KEY'],
      'clientSecret': payment_intent.client_secret
    }
  end

  def recent_accounts
    accounts = Stripe::Account.list({limit: 10})
    render json: {'accounts': accounts}
  end

  def express_dashboard_link
    account_id = params[:account_id]
    link = Stripe::Account.create_login_link(account_id, redirect_url: (request.base_url))
    render json: {'url': link.url}
  end

  def webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
  
    event = nil
  
    # Verify webhook signature and extract the event.
    # See https://stripe.com/docs/webhooks/signatures for more information.
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      # Invalid payload.
      puts e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid Signature.
      puts payload
      puts sig_header
      puts ENV['STRIPE_WEBHOOK_SECRET']
      status 400
      return
    end
  
    if event['type'] == 'payment_intent.succeeded'
      payment_intent = event['data']['object']
      handle_successful_payment_intent(payment_intent)
    end
  
    status 200
  end

  def handle_successful_payment_intent(payment_intent)
    # Fulfill the purchase.
    puts 'PaymentIntent: ' + payment_intent.to_s
  end

  def calculate_order_amount(items)
    # Replace this constant with a calculation of the order's amount
    # Calculate the order total on the server to prevent
    # people from directly manipulating the amount on the client
    50000
  end
  
  def calculate_application_fee_amount(amount)
    # Take a 10% cut.
    (0.1 * amount).to_i
  end
  
  
end
