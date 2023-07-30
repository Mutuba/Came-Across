# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  let(:valid_attributes) do
    {
      name: 'Test Location',
      latitude: 40.7128,
      longitude: -74.0060
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      latitude: nil,
      longitude: -200
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get locations_path
      expect(response).to be_successful
    end

    it 'assigns all locations as @locations' do
      location = Location.create!(valid_attributes)
      get locations_path
      expect(assigns(:locations)).to eq([location])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      location = Location.create!(valid_attributes)
      get location_path(location)
      expect(response).to be_successful
    end

    it 'assigns the requested location as @location' do
      location = Location.create!(valid_attributes)
      get location_path(location)
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_location_path
      expect(response).to be_successful
    end

    it 'assigns a new location as @location' do
      get new_location_path
      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get locations_path
      expect(response).to be_successful
    end

    it 'assigns all locations as @locations' do
      location = Location.create!(valid_attributes)
      get locations_path
      expect(assigns(:locations)).to eq([location])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      location = Location.create!(valid_attributes)
      get location_path(location)
      expect(response).to be_successful
    end

    it 'assigns the requested location as @location' do
      location = Location.create!(valid_attributes)
      get location_path(location)
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_location_path
      expect(response).to be_successful
    end

    it 'assigns a new location as @location' do
      get new_location_path
      expect(assigns(:location)).to be_a_new(Location)
    end
  end
end
