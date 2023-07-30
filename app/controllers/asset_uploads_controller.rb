# frozen_string_literal: true

# app/controllers/image_uploads_controller.rb
class AssetUploadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if asset_missing?
      return render json: { error: 'Oops! File must exist' },
                    status: :unprocessable_entity
    end

    result = Cloudinary::CloudinaryUploadService.call(
      file: params[:file],
      folder: 'come_across_uploads'
    )
    if result.success
      render json: { url: result.secure_url }, status: :ok
    else
      render json: { error: result.error_message },
             status: :unprocessable_entity
    end
  end

  def asset_missing?
    params[:file].nil? || params[:file].blank?
  end
end
