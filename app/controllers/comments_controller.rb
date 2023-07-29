# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_location, only: %i[create show edit update destroy]

  def create
    @comment = @location.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @location, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @location }
      end
    else
      respond_to do |format|
        errors_message = @comment.errors.full_messages.join(', ')
        format.html { render 'locations/show', alert: errors_message }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @comment = @location.comments.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def edit
    @comment = @location.comments.find(params[:id])
  end

  def cancel_edit
    respond_to do |format|
      format.html { redirect_to @location, notice: 'Changes not saved.' }
      format.json { render json: { status: 'error', message: 'Changes not saved.' }, status: :unprocessable_entity }
    end
  end

  def update
    @comment = @location.comments.find(params[:id])
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @location, notice: 'Comment was successfully updated.' }
        format.json { render json: @comment, status: :ok, location: @location }
      end
    else
      respond_to do |format|
        format.html { render 'locations/show', alert: @comment.errors.full_messages.join(', ') }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @location.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @location, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def find_location
    @location = Location.find(params[:location_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
