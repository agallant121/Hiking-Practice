require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @trip_1 = Trip.create(name: "Acadia", start_date: "1999/01/20", end_date: "1999/01/20")
    @trip_2 = Trip.create(name: "Mt. Washington", start_date: "1999/02/25", end_date: "1999/02/25")
    @trip_3 = Trip.create(name: "Mt. Everest", start_date: "1999/05/27", end_date: "1999/05/28")

    visit "/trips"
  end

  it "shows the hikin trip names within the trip index" do
    within"#trip-#{@trip_1.id}" do
      expect(page).to have_content(@trip_1.name)
    end

    within"#trip-#{@trip_2.id}" do
      expect(page).to have_content(@trip_2.name)
    end

    within"#trip-#{@trip_3.id}" do
      expect(page).to have_content(@trip_3.name)
    end
  end

  it "each name is a link to the trip's show page" do
    expect(page).to have_link(@trip_1.name)
    expect(page).to have_link(@trip_2.name)
    expect(page).to have_link(@trip_3.name)
  end
end
# User Story 1 of 10
#
# As a visitor,
# when I visit the hiking trips index page,
# I see a list of all hiking trip names in
# the database.
