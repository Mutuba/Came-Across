# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_location, only: %i[create show edit update destroy cancel_edit]
  before_action :set_comment, only: %i[show edit update destroy]

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
        format.html { redirect_to @location, notice: errors_message }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @comment }
    end
  end

  def edit; end

  def cancel_edit
    respond_to do |format|
      format.html { redirect_to @location, notice: 'Changes were not saved.' }
      format.json do
        render json: { message: 'Changes were not saved.' }, status: :unprocessable_entity
      end
    end
  end

  def update
    @commments = @location.comments
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @location, notice: 'Comment was successfully updated.' }
        format.json { render json: @comment, status: :ok, location: @location }
      end
    else
      respond_to do |format|
        format.html do
          redirect_to @location, alert: @comment.errors.full_messages.join(', ')
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @location, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_comment
    location = Location.find(params[:location_id])
    @comment = location.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
