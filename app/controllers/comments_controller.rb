class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    @comments = @comment.post.comments
  end

  def destroy
     Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
     @comments = Post.find(params[:post_id]).comments
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
