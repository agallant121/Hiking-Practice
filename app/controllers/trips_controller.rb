class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:trip_id])
  end
end
