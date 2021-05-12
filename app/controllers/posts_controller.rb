class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to posts_path
  end

  def show
  end

  def index
  end

  def edit
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :image)
  end
  
end
