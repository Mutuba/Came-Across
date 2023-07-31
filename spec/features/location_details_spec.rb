# frozen_string_literal: true

# spec/features/location_details_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing Location Details', type: :feature do
  let!(:location) do
    create(:location,
           :location_with_comments,
           name: 'Test Location',
           latitude: 43.5521568,
           longitude: 7.0288897)
  end

  scenario 'User clicks on View Location Details button' do
    # Navigate to the page with the View Location Details button
    visit locations_path

    # Click on the View Location Details button
    click_link 'View Location Details'

    # Assert that we are now on the location details page
    expect(page).to have_current_path(location_path(location))

    # Assert that the location details are displayed on the page
    expect(page).to have_content('Test Location')
    expect(page).to have_content('Latitude: 43.5521568')
    expect(page).to have_content('Longitude: 7.0288897')

    expect(page).to have_content('Comments')
    expect(page).to have_selector(
      '.comments-content',
      text: /#{Regexp.escape(Comment.last.content.to_plain_text)}/i
    )

    expect(page).to have_button('Delete Comment')
    expect(page).to have_button('Update Comment')

    expect(page).to have_link(
      'Delete Location',
      href: location_path(location),
      class: 'btn btn-danger btn-sm',
      visible: :all,
      exact: true
    )
    expect(page).to have_link(
      'Update Location',
      href: edit_location_path(location),
      class: 'btn btn-primary btn-sm',
      visible: :all,
      exact: true
    )
  end
end
