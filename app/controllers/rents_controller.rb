class RentsController < ApplicationController
  before_action :set_car, except: [:payment_return]
  before_action :set_rent, only: %i[ show edit update destroy cancel ]
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
    authorize @rent, :new?
    redirect_to(car_path(@car), notice: "The dates is not valid") if params[:start_date].nil? || params[:finish_date].nil?
    redirect_to(profiles_path, notice: "You can't rent a car before your account approved.") and return unless current_user.approved?
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
      customer: current_user.stripe_customer.customer_id,
      transfer_data: {
        destination: @car.user.stripe_account.account_id,
      },
      on_behalf_of: @car.user.stripe_account.account_id
    })

    @rent = Rent.create!(car: @car, renter: current_user, owner: @car.user, start_date: @start_date, finish_date: @finish_date, payment_intent_response: payment_intent, amount: amount, payment_intent_id: payment_intent[:id], insurance: @insurance, fee: @fee)

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

  def cancel
    redirect_to(bookings_profiles_path, notice: "You can't cancel a booking that is past the start time") and return if @rent.start_date < DateTime.now

    canceled_payment_intent = Stripe::Refund.create(payment_intent: @rent.payment_intent_id)
    if canceled_payment_intent['status'] == 'succeeded'
      @rent.update!(canceled_response: canceled_payment_intent, payment_status: :canceled)
    else
      redirect_to bookings_profiles_path, notice: "An error accured. Please contact us"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:car_id])
    end

    def set_rent
      @rent = Rent.find(params[:id] || params[:rent_id])
    end

    # Only allow a list of trusted parameters through.
    def rent_params
      params.require(:rent).permit(:car_id, :renter_id, :owner_id, :start_date_id, :car_id_id, :start_date, :finish_date)
    end

    def total_amount
      @start_date = params[:start_date].present? ? DateTime.parse(params[:start_date]) : DateTime.now
      @finish_date = params[:finish_date].present? ? DateTime.parse(params[:finish_date]) : DateTime.now + 1.day
      
      day_count = (@finish_date - @start_date).to_i
      if day_count < 1
        day_count = 1
      end

      @total_car_price = day_count * @car.price

      @fee = @total_car_price * 0.1
      
      @insurance = @total_car_price * 0.1 * (params[:insurance] == 'true' ? 1 : 0)

      @total_amount = @total_car_price + @fee + @insurance
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
