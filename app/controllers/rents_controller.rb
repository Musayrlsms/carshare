class RentsController < ApplicationController
  before_action :set_car, except: [:payment_return]
  before_action :set_rent, only: %i[ show edit update destroy ]
  before_action :total_amount, only: [ :new ]

  # GET /rents or /rents.json
  def index
    @rents = Rent.all
  end

  # GET /rents/1 or /rents/1.json
  def show
  end

  # GET /rents/new
  def new
    @rent = @car.rents.new
  end

  # GET /rents/1/edit
  def edit
  end

  # POST /rents or /rents.json
  def create
    @rent = Rent.new(rent_params)

    respond_to do |format|
      if @rent.save
        format.html { redirect_to rent_url(@rent), notice: "Rent was successfully created." }
        format.json { render :show, status: :created, location: @rent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rents/1 or /rents/1.json
  def update
    respond_to do |format|
      if @rent.update(rent_params)
        format.html { redirect_to rent_url(@rent), notice: "Rent was successfully updated." }
        format.json { render :show, status: :ok, location: @rent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rents/1 or /rents/1.json
  def destroy
    @rent.destroy

    respond_to do |format|
      format.html { redirect_to rents_url, notice: "Rent was successfully destroyed." }
      format.json { head :no_content }
    end
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
        destination: @car.user.stripe_account.account_id,
      },
      on_behalf_of: @car.user.stripe_account.account_id
    })

    @rent = Rent.create(car: @car, renter: current_user, owner: @car.user, start_date: @start_date, finish_date: @finish_date, payment_intent_response: payment_intent, amount: amount, payment_intent_id: payment_intent[:id])

    render json: {
      'publishableKey': ENV['STRIPE_PUBLISHABLE_KEY'],
      'clientSecret': payment_intent.client_secret
    }
  end

  def recent_accounts
    accounts = Stripe::Account.list({limit: 1})
    render json: {'accounts': accounts}
  end

  def payment_return
    payment_response = Stripe::PaymentIntent.retrieve(params['payment_intent'])
    @rent = Rent.find_by(payment_intent_id: payment_response['id'])
    
    # TODO: check car price

    if @rent.amount == payment_response['amount']
      @rent.update!(payment_status: :paid, payment_intent_response: payment_response)
    else
      render :new, notice: "Rent was successfully updated."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:car_id])
    end

    def set_rent
      @rent = Rent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rent_params
      params.require(:rent).permit(:car_id, :renter_id, :owner_id, :start_date_id, :car_id_id, :start_date, :finish_date)
    end

    def total_amount
      @start_date = DateTime.parse(params[:start_date])
      @finish_date = DateTime.parse(params[:finish_date])
      @total_amount = (@finish_date - @start_date).to_i * @car.price
    end

    def handle_successful_payment_intent(payment_intent)
      # Fulfill the purchase.
      puts 'PaymentIntent: ' + payment_intent.to_s
    end
  
    def calculate_order_amount(items)
      # Replace this constant with a calculation of the order's amount
      # Calculate the order total on the server to prevent
      # people from directly manipulating the amount on the client
      total_amount.to_i * 100
    end
    
    def calculate_application_fee_amount(amount)
      # Take a 10% cut.
      (0.1 * amount).to_i
    end
end
