require 'rails_helper'

describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :start_date}
    it {should validate_presence_of :end_date}
  end


  describe 'relationships' do
    it {should have_many :trip_trails}
    it {should have_many(:trails).through(:trip_trails)}
  end

  it "instance methods" do
    trip_1 = Trip.create(name: "Acadia", start_date: "1999/01/20", end_date: "1999/01/20")

    trail_1 = trip_1.trails.create(name: "Mountain Lion Trail", address: "404 Mountain Rd", length: 5)
    trail_2 = trip_1.trails.create(name: "Beaver Trail", address: "56 Carlton Rd", length: 10)
    trail_3 = trip_1.trails.create(name: "Moose Trail", address: "835 Will Rd", length: 15)

    expect(trip_1.total_hike).to eq(30)
    expect(trip_1.avg_trail_hike).to eq(10)
    expect(trip_1.longest_hike).to eq("Moose Trail, 15")
    expect(trip_1.shortest_hike).to eq("Mountain Lion Trail, 5")
  end
end
