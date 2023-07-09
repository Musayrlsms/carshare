class DashboardController < ApplicationController
  def index
    @cars = Car.all

  end
end
