require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @trip_1 = Trip.create(name: "Acadia", start_date: "1999/01/20", end_date: "1999/01/20")
    @trip_2 = Trip.create(name: "Mt. Washington", start_date: "1999/02/25", end_date: "1999/02/25")
    @trip_3 = Trip.create(name: "Mt. Everest", start_date: "1999/05/27", end_date: "1999/05/28")

    @trail_1 = Trail.create(name: "Mountain Lion Trail", address: "404 Mountain Rd", length: 5)
    @trail_2 = Trail.create(name: "Beaver Trail", address: "56 Carlton Rd", length: 10)
    @trail_3 = Trail.create(name: "Moose Trail", address: "835 Will Rd", length: 15)

    @trip_1.trails << [@trail_1, @trail_2]
    @trip_2.trails << [@trail_1, @trail_3]
    @trip_3.trails << [@trail_1, @trail_2, @trail_3]

    visit "/trails/#{@trail_1.id}"
  end

  it "shows name and address of trail on trail show page" do
    expect(page).to have_content(@trail_1.name)
    expect(page).to have_content(@trail_1.address)
  end

  it "shows the trips and mileage this trail has been a part of" do
    within"#trip-#{@trip_1.id}" do
      expect(page).to have_content(@trip_1.name)
      expect(page).to have_content("Total Mileage: 15 miles")
    end

    within"#trip-#{@trip_2.id}" do
      expect(page).to have_content(@trip_2.name)
      expect(page).to have_content("Total Mileage: 20 miles")
    end

    within"#trip-#{@trip_3.id}" do
      expect(page).to have_content(@trip_3.name)
      expect(page).to have_content("Total Mileage: 30 miles")
    end
  end

  it "includes total number of trips where this trail was included" do
    expect(page).to have_content("Total Trips that include this trail: 3")
  end
end
# User Story 9 of 10
#
# As a visitor,
# when I visit a trail's page,
# I see the name and address of this trail.
# I also see the name and total length of
# every hiking trip that includes this trail
