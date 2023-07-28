# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  def index
    @locations = Location.includes(comments: :rich_text_content)
    .page(params[:page])
    .order(updated_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @locations }
    end
  end

  # GET /locations/1 or /locations/1.json
  def show
    @comments = @location.comments.page(params[:page]).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
    @location.comments.build


    respond_to do |format|
      format.html
      format.json { render json: @location }
    end
  end

  def edit
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @location }
    end
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html do
          redirect_to location_url(@location),
                      flash: { notice: 'Location was successfully created.' }
        end
        format.json { render :show, status: :created, location: @location }
      else
        errors_message = @location.errors.full_messages.join(', ')
        format.html do
          redirect_to new_location_url,
                      alert: errors_message,
                      cstatus: :unprocessable_entity
        end

        format.json do
          render json: @location.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html do
          redirect_to location_url(@location),
                      notice: 'Location was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @location }
      else
        errors_message = @location.errors.full_messages.join(', ')
        format.html do
          redirect_to edit_location_url, alert:
          errors_message, status: :unprocessable_entity
        end
        format.json do
          render json: @location.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html do
        redirect_to locations_url,
                    notice: 'Location was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_location
    @location = Location.includes(comments: :rich_text_content).find(params[:id])
  end

  def location_params
    params.require(:location).permit(
      :name,
      :latitude,
      :longitude,
      :dates,
      ratings: Location::CATEGORIES,
      comments_attributes: [:id, :content, :_destroy]
    )
  end
end
