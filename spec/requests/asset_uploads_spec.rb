# frozen_string_literal: true

# spec/requests/image_uploads_spec.rb
require 'rails_helper'

RSpec.describe 'ImageUploads', type: :request do
  describe 'POST /image_uploads' do
    let(:file) do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec',
                        'fixtures', 'random-image.jpeg'), 'image/jpg'
      )
    end

    context 'with a valid file' do
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
        post asset_uploads_path, params: { file: }
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the URL of the uploaded image' do
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('url')
        expect(json_response['url']).to eq('https://example.com/image.jpeg')
      end
    end

    context 'with a nil file' do
      before do
        post asset_uploads_path, params: { file: nil }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end
    end

    context 'with a possibly malformed file' do
      before do
        expect(ActionDispatch::Http::UploadedFile).to receive(:new)
          .and_return(file)
        expect(Cloudinary::CloudinaryUploadService)
          .to receive(:call)
          .with(file:, folder: 'come_across_uploads')
          .and_return(
            OpenStruct.new(
              success: false, error_message: 'malformed file'
            )
          )
        post asset_uploads_path, params: { file: }
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
