# frozen_string_literal: true

# app/services/cloudinary_upload_service.rb

module Cloudinary
  class CloudinaryUploadService < ApplicationService
    def initialize(**params)
      super() # Prodent to ensure parent initialize method is called before child's
      @file = params.fetch(:file)
      @folder = params.fetch(:folder, 'default_folder')
    end

    def call
      response = Cloudinary::Uploader.upload(@file, folder: @folder)
      OpenStruct.new(
        success: true,
        public_id: response['public_id'],
        secure_url: response['secure_url'],
        error_message: nil
      )
    rescue CloudinaryException => e
      OpenStruct.new(
        success: false,
        public_id: nil,
        secure_url: nil,
        error_message: e.message
      )
    end
  end
end
