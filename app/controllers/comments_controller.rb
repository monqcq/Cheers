class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
     Comment.find_by(id: params[:id], book_id: params[:post_id]).destroy
     redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
