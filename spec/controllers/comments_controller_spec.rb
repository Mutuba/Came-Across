# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:location) { create(:location) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:comment) }

      it 'creates a new Comment' do
        expect do
          post :create, params: { location_id: location.id, comment: valid_attributes }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the location' do
        post :create, params: { location_id: location.id, comment: valid_attributes }
        expect(response).to redirect_to(location_url(location))
      end

      it 'sets the success flash notice' do
        post :create, params: { location_id: location.id, comment: valid_attributes }
        expect(flash[:notice]).to eq('Comment was successfully created.')
      end

      it 'returns a success JSON response' do
        post :create, params: { location_id: location.id, comment: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
        expect(json).not_to be_empty
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:comment, content: '') }

      it 'does not create a new Comment' do
        expect do
          post :create, params: { location_id: location.id, comment: invalid_attributes }
        end.to_not change(Comment, :count)
      end

      it 'redirects the location show template' do
        post :create, params: { location_id: location.id, comment: invalid_attributes }
        expect(response).to redirect_to(location)
      end

      it 'returns an error JSON response' do
        post :create, params: { location_id: location.id, comment: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to have_key('content')
      end
    end
  end

  describe 'GET #show' do
    let(:comment) { create(:comment, location: location) }
    it 'returns a success JSON response' do
      get :show, params: { location_id: location.id, id: comment.id }, format: :json
      expect(response).to be_successful
      expect(json).not_to be_empty
    end
  end

  describe 'GET #edit' do
    let(:comment) { create(:comment, location: location) }

    it 'returns a success response' do
      get :edit, params: { location_id: location.id, id: comment.id }
      expect(response).to be_successful
    end

    it 'renders the edit template' do
      get :edit, params: { location_id: location.id, id: comment.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment, location: location) }

    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:comment) }

      it 'updates the requested comment' do
        patch :update, params: { location_id: location.id, id: comment.id, comment: valid_attributes }
        comment.reload
        expect(comment.content.to_plain_text).to eq(valid_attributes[:content])
      end

      it 'redirects to the location' do
        patch :update, params: { location_id: location.id, id: comment.id, comment: valid_attributes }
        expect(response).to redirect_to(location_url(location))
      end

      it 'sets the success flash notice' do
        patch :update, params: { location_id: location.id, id: comment.id, comment: valid_attributes }
        expect(flash[:notice]).to eq('Comment was successfully updated.')
      end

      it 'returns a success JSON response' do
        patch :update, params: {
          location_id: location.id, id: comment.id, comment: valid_attributes
        }, format: :json
        expect(response).to have_http_status(:ok)
        expect(json).not_to be_empty
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:comment, content: '') }

      it 'does not update the requested comment' do
        original_content = comment.content
        patch :update, params: { location_id: location.id, id: comment.id, comment: invalid_attributes }
        comment.reload
        expect(comment.content).to eq(original_content)
      end

      it 'redirects the location template' do
        patch :update, params: {
          location_id: location.id,
          id: comment.id,
          comment: invalid_attributes
        }
        expect(response).to redirect_to(location)
      end

      it 'returns an error JSON response' do
        patch :update, params: {
          location_id: location.id,
          id: comment.id,
          comment: invalid_attributes
        }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to have_key('content')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, location: location) }

    it 'destroys the requested comment' do
      expect do
        delete :destroy, params: { location_id: location.id, id: comment.id }
      end.to change(Comment, :count).by(-1)
    end

    it 'redirects to the location' do
      delete :destroy, params: { location_id: location.id, id: comment.id }
      expect(response).to redirect_to(location_url(location))
    end

    it 'sets the success flash notice' do
      delete :destroy, params: { location_id: location.id, id: comment.id }
      expect(flash[:notice]).to eq('Comment was successfully deleted.')
    end

    it 'returns a success JSON response' do
      delete :destroy, params: { location_id: location.id, id: comment.id }, format: :json
      expect(response).to have_http_status(:no_content)
      expect(response.body).to be_empty
    end
  end

  describe 'POST #cancel_edit' do
    let!(:comment) { create(:comment, location: location) }
    context 'when format is HTML' do
      it 'redirects to the location and sets the notice message' do
        get :cancel_edit, params: { location_id: location.id, id: comment.id }, format: :html

        expect(response).to redirect_to(location)
        expect(flash[:notice]).to eq('Changes were not saved.')
      end
    end

    context 'when format is JSON' do
      it 'returns the correct JSON response' do
        get :cancel_edit, params: { location_id: location.id, id: comment.id }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['message']).to eq('Changes were not saved.')
      end
    end
  end
end
