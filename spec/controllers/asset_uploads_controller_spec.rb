# frozen_string_literal: true

# spec/controllers/asset_uploads_controller_spec.rb
require 'rails_helper'

RSpec.describe AssetUploadsController, type: :controller do
  describe 'POST #create' do
    let(:file) do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec',
                        'fixtures', 'random-image.jpeg'), 'image/jpg'
      )
    end

    context 'with valid file' do
      before do
        expect(ActionDispatch::Http::UploadedFile).to receive(:new)
          .and_return(file)
        expect(Cloudinary::CloudinaryUploadService)
          .to receive(:call)
          .with(file:, folder: 'come_across_uploads')
          .and_return(
            OpenStruct.new(
              success: true, secure_url: 'https://example.com/image.jpeg'
            )
          )

        post :create, params: { file: }
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)

        expect(response).to be_successful
      end

      it 'returns the URL of the uploaded image' do
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('url')
        expect(json['url']).to eq('https://example.com/image.jpeg')
      end
    end

    context 'with nil file' do
      before do
        post :create, params: { file: nil }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end
    end

    context 'with possibly malformed file' do
      before do
        expect(ActionDispatch::Http::UploadedFile).to receive(:new)
          .and_return(file)
        expect(Cloudinary::CloudinaryUploadService)
          .to receive(:call)
          .with(file:, folder: 'come_across_uploads')
          .and_return(
            OpenStruct.new(
              success: false, secure_url: nil, error_message: 'Invalid file'
            )
          )
        post :create, params: { file: }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end
    end
  end
end
