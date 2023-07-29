# frozen_string_literal: true

# spec/controllers/locations_controller_spec.rb

require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
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
      get :index
      expect(response).to be_successful
    end

    it 'assigns all locations as @locations' do
      location = Location.create!(valid_attributes)
      get :index
      expect(assigns(:locations)).to eq([location])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      location = Location.create!(valid_attributes)
      get :show, params: { id: location.to_param }
      expect(response).to be_successful
    end

    it 'assigns the requested location as @location' do
      location = Location.create!(valid_attributes)
      get :show, params: { id: location.to_param }
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new location as @location' do
      get :new
      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      location = Location.create!(valid_attributes)
      get :edit, params: { id: location.to_param }
      expect(response).to be_successful
    end

    it 'assigns the requested location as @location' do
      location = Location.create!(valid_attributes)
      get :edit, params: { id: location.to_param }
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Location' do
        expect do
          post :create, params: { location: valid_attributes }
        end.to change(Location, :count).by(1)
      end

      it 'redirects to the created location' do
        post :create, params: { location: valid_attributes }
        expect(response).to redirect_to(Location.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Location' do
        expect do
          post :create, params: { location: invalid_attributes }
        end.to_not change(Location, :count)
      end

      it 're-renders the :new template with alert message' do
        post :create, params: { location: invalid_attributes }
        expect(response).to redirect_to(new_location_url)
      end
    end
  end

  describe 'PATCH #update' do
    let(:location) { Location.create!(valid_attributes) }

    context 'with valid params' do
      it 'updates the requested location' do
        patch :update, params: { id: location.to_param, location: { name: 'Updated Location' } }
        location.reload
        expect(location.name).to eq('Updated Location')
      end

      it 'redirects to the location' do
        patch :update, params: { id: location.to_param, location: valid_attributes }
        expect(response).to redirect_to(location)
      end
    end

    context 'with invalid params' do
      it 'does not update the location' do
        patch :update, params: { id: location.to_param, location: { name: '' } }
        location.reload
        expect(location.name).not_to eq('')
      end

      it 're-renders the :edit template' do
        patch :update, params: { id: location.to_param, location: invalid_attributes }
        expect(response).to redirect_to(edit_location_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:location) { Location.create!(valid_attributes) }

    it 'destroys the requested location' do
      expect do
        delete :destroy, params: { id: location.to_param }
      end.to change(Location, :count).by(-1)
    end

    it 'redirects to the locations list' do
      delete :destroy, params: { id: location.to_param }
      expect(response).to redirect_to(locations_url)
    end
  end
end
