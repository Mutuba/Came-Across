# frozen_string_literal: true

# spec/requests/comments_spec.rb
require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:location) { create(:location) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:comment) }

      it 'creates a new Comment' do
        expect do
          post location_comments_path(location), params: { comment: valid_attributes }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the location' do
        post location_comments_path(location), params: { comment: valid_attributes }
        expect(response).to redirect_to(location_url(location))
      end

      it 'sets the success flash notice' do
        post location_comments_path(location), params: { comment: valid_attributes }
        expect(flash[:notice]).to eq('Comment was successfully created.')
      end

      it 'returns a success JSON response' do
        post location_comments_path(location), params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.body).not_to be_empty
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:comment, content: '') }

      it 'does not create a new Comment' do
        expect do
          post location_comments_path(location), params: { comment: invalid_attributes }
        end.to_not change(Comment, :count)
      end

      it 're-renders the location show template' do
        post location_comments_path(location), params: { comment: invalid_attributes }
        expect(response).to redirect_to(location)
      end

      it 'returns an error JSON response' do
        post location_comments_path(location), params: { comment: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('content')
      end
    end
  end

  describe 'GET #show' do
    let(:comment) { create(:comment, location: location) }

    it 'returns a success JSON response' do
      get location_comment_path(location, comment), as: :json
      expect(response).to be_successful
      expect(response.body).not_to be_empty
    end
  end

  describe 'GET #edit' do
    let(:comment) { create(:comment, location: location) }

    it 'returns a success response' do
      get edit_location_comment_path(location, comment)
      expect(response).to be_successful
    end

    it 'renders the edit template' do
      get edit_location_comment_path(location, comment)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment, location: location) }

    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:comment) }

      it 'updates the requested comment' do
        patch location_comment_path(location, comment), params: { comment: valid_attributes }
        comment.reload
        expect(comment.content.to_plain_text).to eq(valid_attributes[:content])
      end

      it 'redirects to the location' do
        patch location_comment_path(location, comment), params: { comment: valid_attributes }
        expect(response).to redirect_to(location_url(location))
      end

      it 'sets the success flash notice' do
        patch location_comment_path(location, comment), params: { comment: valid_attributes }
        expect(flash[:notice]).to eq('Comment was successfully updated.')
      end

      it 'returns a success JSON response' do
        patch location_comment_path(location, comment), params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to be_empty
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:comment, content: '') }

      it 'does not update the requested comment' do
        original_content = comment.content

        patch location_comment_path(location, comment), params: { comment: invalid_attributes }
        comment.reload
        expect(comment.content.to_plain_text).to eq(original_content.to_plain_text)
      end

      it 're-renders the location show template' do
        patch location_comment_path(location, comment), params: { comment: invalid_attributes }
        expect(response).to redirect_to(location_url(location))
      end

      it 'returns an error JSON response' do
        patch location_comment_path(location, comment), params: { comment: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('content')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, location: location) }

    it 'destroys the requested comment' do
      expect do
        delete location_comment_path(location, comment)
      end.to change(Comment, :count).by(-1)
    end

    it 'redirects to the location' do
      delete location_comment_path(location, comment)
      expect(response).to redirect_to(location_url(location))
    end

    it 'sets the success flash notice' do
      delete location_comment_path(location, comment)
      expect(flash[:notice]).to eq('Comment was successfully deleted.')
    end

    it 'returns a success JSON response' do
      delete location_comment_path(location, comment), as: :json
      expect(response).to have_http_status(:no_content)
      expect(response.body).to be_empty
    end
  end

  describe 'POST #cancel_edit' do
    let!(:comment) { create(:comment, location: location) }

    context 'when format is HTML' do
      it 'redirects to the location and sets the notice message' do
        get cancel_edit_location_comment_path(location, comment), as: :html

        expect(response).to redirect_to(location)
        expect(flash[:notice]).to eq('Changes were not saved.')
      end
    end

    context 'when format is JSON' do
      it 'returns the correct JSON response' do
        get cancel_edit_location_comment_path(location, comment), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['message']).to eq('Changes were not saved.')
      end
    end
  end
end
