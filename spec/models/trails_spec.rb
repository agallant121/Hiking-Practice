require 'rails_helper'

describe Trail, type: :model do
  describe 'validations' do
    it { should validate_presence_of :length }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }

    it { should validate_numericality_of(:length).only_integer }
    it { should validate_numericality_of(:length).is_greater_than(0) }
  end

  describe 'relationships' do
    it {should have_many :trip_trails}
    it {should have_many(:trips).through(:trip_trails)}
  end

  it "instance method" do
    trip_1 = Trip.create(name: "Acadia", start_date: "1999/01/20", end_date: "1999/01/20")
    trip_2 = Trip.create(name: "Mt. Washington", start_date: "1999/02/25", end_date: "1999/02/25")
    trip_3 = Trip.create(name: "Mt. Everest", start_date: "1999/05/27", end_date: "1999/05/28")

    trail_1 = Trail.create(name: "Mountain Lion Trail", address: "404 Mountain Rd", length: 5)
    trail_2 = Trail.create(name: "Beaver Trail", address: "56 Carlton Rd", length: 10)
    trail_3 = Trail.create(name: "Moose Trail", address: "835 Will Rd", length: 15)

    trip_1.trails << [trail_1, trail_2]
    trip_2.trails << [trail_1, trail_3]
    trip_3.trails << [trail_1, trail_2, trail_3]

    expect(trail_1.total_use).to eq(3)
  end
end
