# frozen_string_literal: true

# spec/services/cloudinary_upload_service_spec.rb

require 'rails_helper'

RSpec.describe Cloudinary::CloudinaryUploadService, type: :service do
  describe '#call' do
    context 'when Cloudinary upload is successful' do
      let(:file) { File.open(Rails.root.join('spec', 'fixtures', 'random-image.jpeg')) }
      let(:folder) { 'test_folder' }

      before do
        # Stub Cloudinary::Uploader.upload to return a mock response for success
        response = { 'public_id' => 'public_id123', 'secure_url' => 'https://example.com/image.jpg' }
        allow(Cloudinary::Uploader).to receive(:upload).and_return(response)
      end

      it 'uploads the file to Cloudinary with the given folder' do
        service = Cloudinary::CloudinaryUploadService.new(file: file, folder: folder)
        result = service.call

        expect(Cloudinary::Uploader).to have_received(:upload).with(file, folder: folder)
        expect(result.success).to be true
        expect(result.public_id).to eq 'public_id123'
        expect(result.secure_url).to eq 'https://example.com/image.jpg'
        expect(result.error_message).to be_nil
      end

      it 'uploads the file to Cloudinary with the default folder when folder is not provided' do
        service = Cloudinary::CloudinaryUploadService.new(file: file)
        result = service.call

        expect(Cloudinary::Uploader).to have_received(:upload).with(file, folder: 'default_folder')
        expect(result.success).to be true
        expect(result.public_id).to eq 'public_id123'
        expect(result.secure_url).to eq 'https://example.com/image.jpg'
        expect(result.error_message).to be_nil
      end
    end

    context 'when Cloudinary upload fails' do
      let(:file) { File.open(Rails.root.join('spec', 'fixtures', 'random-image.jpeg')) }
      let(:folder) { 'test_folder' }

      before do
        # Stub Cloudinary::Uploader.upload to raise a CloudinaryException for failure
        allow(Cloudinary::Uploader).to receive(:upload).and_raise(CloudinaryException, 'Upload failed')
      end

      it 'returns a failure response with error message' do
        service = Cloudinary::CloudinaryUploadService.new(file: file, folder: folder)
        result = service.call

        expect(Cloudinary::Uploader).to have_received(:upload).with(file, folder: folder)
        expect(result.success).to be false
        expect(result.public_id).to be_nil
        expect(result.secure_url).to be_nil
        expect(result.error_message).to eq 'Upload failed'
      end
    end
  end
end
