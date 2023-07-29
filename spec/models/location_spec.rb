# frozen_string_literal: true

# spec/models/location_spec.rb

require 'rails_helper'

RSpec.describe Location, type: :model do
  subject(:location) { build(:location, address: nil) }

  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:comments).allow_destroy(true) }
  end

  describe 'geocoding' do
    it 'should geocode the address after validation if address_changed?' do
      location.address = 'New Address, City'
      expect(location).to receive(:geocode)
      location.valid?
    end

    it 'should not geocode the address if address is not changed' do
      expect(location).not_to receive(:geocode)
      location.valid?
    end
  end

  describe '#process_ratings' do
    it 'should remove empty values from ratings' do
      location.ratings = { 'Landscape' => '', 'People' => '', 'Food' => '' }
      location.send(:process_ratings)
      expect(location.ratings).to eq({})
    end

    it 'should convert ratings values to integers if present' do
      location.ratings = { 'Landscape' => '3', 'People' => '', 'Food' => '4' }
      location.send(:process_ratings)
      expect(location.ratings).to eq({ 'Landscape' => 3, 'Food' => 4 })
    end
  end

  describe 'callback order' do
    it 'should call process_ratings before validation' do
      expect(location).to receive(:process_ratings)
      location.valid?
    end
  end

  describe '.update_categories' do
    it 'sets the CATEGORIES constant with category names' do
      categories = create_list(:category, 3)
      Location.update_categories

      expect(Location::CATEGORIES).to match_array(categories.pluck(:name))
    end
  end
end
