# frozen_string_literal: true

# app/controllers/image_uploads_controller.rb
class ImageUploadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    result = Cloudinary::CloudinaryUploadService.call(file: params[:file], folder: 'come_across_uploads')

    if result.success?
      render json: { url: result.secure_url }
    else
      render json: { error: result.error_message }, status: :unprocessable_entity
    end
  end
end
