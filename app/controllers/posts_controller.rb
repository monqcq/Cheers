class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
    @comments = @post.comments
    @comment = Comment.new
  end

  def index
    # パラメーターにcategory_idが渡ってきたらそのIDで投稿を取得
    if params[:category_id]
      @search_posts = Post.where(category_id: params[:category_id]).published
    # パラメーターにscene_idが渡ってきたらそのIDで投稿を取得
    elsif params[:scene_id]
      @search_posts = Post.where(scene_id: params[:scene_id]).published
    end
    
    @categories = Category.all
    @scenes = Scene.all
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def draft
    @user = current_user
    @posts = Post.draft.order("created_at DESC")
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image, :status, :category_id, :scene_id)
  end
end
