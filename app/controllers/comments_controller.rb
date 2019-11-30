class CommentsController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @comment = @profile.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to profile_path(@profile), notice: 'Post failed...' }
      end
    end
  end
  def destroy
    @profile = Profile.find(params[:profile_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
        format.html { redirect_to @profile }
        format.js
    end
end
def update
  respond_to do |format|
    if @comment.update(params[:profile_id])
      format.html { redirect_to @profile, notice: 'Profile was  updated.' }
      format.json { render :show, status: :ok, location: @profile }
    else
      format.html { render :edit }
      format.json { render json: @profile.errors, status: :unprocessable_entity }
    end
  end
end
  private
  def comment_params
    params.require(:comment).permit(:profile_id, :content)
  end
end
