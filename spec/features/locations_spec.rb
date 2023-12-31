# frozen_string_literal: true

# spec/features/locations_spec.rb
require 'rails_helper'

RSpec.feature 'Locations', type: :feature do
  let!(:location) { create(:location, name: 'Test Location', latitude: 43.5521568, longitude: 7.0288897) }
  let!(:locations) do
    create_list(:location, 11, name: 'Test Location', latitude: 43.5521568, longitude: 7.0288897)
  end

  scenario 'User visits the locations index page' do
    visit locations_path

    # Check if the page displays the "Locations" heading
    expect(page).to have_content('Locations')

    # Check if the "Add New Location" button is present
    expect(page).to have_link('Add New Location', href: new_location_path)

    # Check if the location details are displayed
    expect(page).to have_content('Test Location')
    expect(page).to have_content('Address: 6 Rue de Bône, 06400 Cannes')
    expect(page).to have_content('Latitude: 43.5521568')
    expect(page).to have_content('Longitude: 7.0288897')

    # Check if the "View Location Details" button is present and has the correct link
    expect(page).to have_link('View Location Details', href: location_path(Location.last))

    expect(page).to have_css('.disabled', text: 'Previous')
    expect(page).not_to have_css('.disabled', text: 'Next')
  end

  scenario 'User sees a message when no locations are available' do
    # Ensure there are no locations
    Location.destroy_all

    visit locations_path

    # Check if the message for no locations is displayed
    expect(page).to have_content('Sorry, not sure if this is what you expected, locations have not been added yet!')
  end

  scenario 'User clicks on Add New Location button' do
    visit locations_path
    click_link('Add New Location')
    expect(page).to have_current_path(new_location_path)
    expect(page).to have_css('form[action="/locations"]')
    expect(page).to have_field('location[name]')
    expect(page).to have_field('location[latitude]')
    expect(page).to have_field('location[longitude]')

    Location::CATEGORIES.each do |category|
      expect(page).to have_field("location[ratings[#{category}]]")
    end

    expect(page).to have_field('location[dates]')

    expect(page).to have_link('Cancel', href: locations_path)
  end
end
