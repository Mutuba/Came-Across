# spec/features/location_form_spec.rb

require 'rails_helper'

RSpec.feature 'Location Form', type: :feature do
  scenario 'User fills in new location details and submits the form' do
    visit locations_path

    click_link('Add New Location')
    expect(page).to have_current_path(new_location_path)

    # Fill in the form fields
    fill_in 'location_name', with: 'New Location Name'
    fill_in 'location_latitude', with: '37.7749'
    fill_in 'location_longitude', with: '-122.4194'

    Location::CATEGORIES.each do |category|
      fill_in "location_ratings_#{category}", with: 5
    end

    fill_in 'location_dates', with: '2023-07-30T12:00'

    # Submit the form
    click_button 'Create Location'
    # Check for the flash message
    expect(page).to have_content('Location was successfully created.')

    # Assuming the form submission will redirect to the show page
    expect(page).to have_content('New Location Name')
    expect(page).to have_content('Latitude: 37.7749')
    expect(page).to have_content('Longitude: -122.4194')
  end
end
