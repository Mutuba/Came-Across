class CommentsController < ApplicationController
  def create
    @location = Location.find(params[:location_id])
    @comment = @location.comments.build(comment_params)
    if @comment.save
      redirect_to @location, notice: 'Comment was successfully created.'
    else
      # Handle validation errors if the comment couldn't be saved
      render 'locations/show'
    end
  end
  
  def destroy
    @location = Location.find(params[:location_id])
    @comment = @location.comments.find(params[:id])
    @comment.destroy
    redirect_to @location, notice: "Comment was successfully deleted."
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
