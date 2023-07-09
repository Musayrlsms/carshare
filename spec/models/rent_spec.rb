require 'rails_helper'

RSpec.describe Rent, type: :model do
  let!(:car_brand) { Brand.create!( name: 'Wolkswagen' ) }
  let!(:car_model) { Model.create!( name: 'Passat', brand: car_brand ) }
  let!(:user_car_owner) { User.create!( email: 'test@example.com', password: SecureRandom.hex(16) ) }
  let!(:user_renter) { User.create!( email: 'test2@example.com', password: SecureRandom.hex(16) ) }
  let!(:car_1) { Car.create!( price: 100, user: user_car_owner, brand: car_brand, model: car_model ) }
  

  let!(:rent_1) { Rent.create!(
    car: car_1,
    renter: user_renter,
    owner: user_car_owner,
    start_date: DateTime.now + 5.days,
    finish_date: DateTime.now + 10.days,
    payment_status: :paid
  ) }
  
  it "should renting by user" do
    rent = Rent.create(
      car: car_1,
      renter: user_renter,
      owner: user_car_owner,
      start_date: DateTime.now + 1.days,
      finish_date: DateTime.now + 4.days,
      payment_status: :paid
    )

    expect(rent.id).not_to eq(nil)
  end

  it "should not renting by user when car is not available" do
    rent = Rent.create(
      car: car_1,
      renter: user_renter,
      owner: user_car_owner,
      start_date: DateTime.now + 1.days,
      finish_date: DateTime.now + 4.days,
      payment_status: :paid
    )

    expect(rent.id).to eq(nil)
  end 
end
