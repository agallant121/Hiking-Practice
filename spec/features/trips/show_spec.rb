require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @trip_1 = Trip.create(name: "Acadia", start_date: "1999/01/20", end_date: "1999/01/20")

    @trail_1 = @trip_1.trails.create(name: "Mountain Lion Trail", address: "404 Mountain Rd", length: 5)
    @trail_2 = @trip_1.trails.create(name: "Beaver Trail", address: "56 Carlton Rd", length: 10)
    @trail_3 = @trip_1.trails.create(name: "Moose Trail", address: "835 Will Rd", length: 15)

    visit "/trips/#{@trip_1.id}"
  end

  it "shows the trip's name" do
    expect(page).to have_content(@trip_1.name)
  end

  it "shows the each trail on the trip and that trail's information" do
    within"#trail-#{@trail_1.id}" do
      expect(page).to have_link(@trail_1.name)
      expect(page).to have_content(@trail_1.address)
      expect(page).to have_content(@trail_1.length)
    end

    within"#trail-#{@trail_2.id}" do
      expect(page).to have_link(@trail_2.name)
      expect(page).to have_content(@trail_2.address)
      expect(page).to have_content(@trail_2.length)
    end

    within"#trail-#{@trail_3.id}" do
      expect(page).to have_link(@trail_3.name)
      expect(page).to have_content(@trail_3.address)
      expect(page).to have_content(@trail_3.length)
    end
  end

  it "shows the total distance traveled on the trip" do
    expect(page).to have_content("Total Hiking Mileage: 30")
  end

  it "shows the average distance traveled per trail" do
    expect(page).to have_content("Average Hiking Mileage: 10")
  end

  it "says the longest trail on the trip" do
    expect(page).to have_content("Longest Hike: Moose Trail, 15 miles")
  end

  it "says the shortest trail on the trip" do
    expect(page).to have_content("Shortest Hike: Mountain Lion Trail, 5 miles")
  end
end
