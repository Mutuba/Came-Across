# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Location Management' do
  let!(:location) { create(:location) }
  let!(:comment) { create(:comment, location: location) }

  scenario 'update a location' do
    visit edit_location_path(location)

    fill_in 'Name', with: 'New Location Name'
    click_button 'Update Location'

    expect(page).to have_content('Location was successfully updated.')
    expect(page).to have_content('New Location Name')
  end

  scenario 'delete a location' do
    visit location_path(location)

    click_link 'Delete Location'

    expect(page).to have_content('Location was successfully deleted.')
    expect(page).not_to have_content(location.name)
  end

  scenario 'delete a comment' do
    visit location_path(location)

    click_button 'Delete Comment'

    expect(page).to have_content('Comment was successfully deleted.')
    expect(page).not_to have_content(comment.content)
  end
end
