class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save && @post.status == "draft"
      redirect_to draft_posts_path
    elsif @post.save
      redirect_to posts_path
    else
      render :new
    end
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
      @search_posts = Post.where(category_id: params[:category_id]).published.order("created_at DESC").page(params[:page]).per(9)
    # パラメーターにscene_idが渡ってきたらそのIDで投稿を取得
    elsif params[:scene_id]
      @search_posts = Post.where(scene_id: params[:scene_id]).published.order("created_at DESC").page(params[:page]).per(9)
    end

    @categories = Category.all
    @scenes = Scene.all

    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
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
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def draft
    @user = current_user
    @posts = Post.draft.order("created_at DESC").page(params[:page]).per(6)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image, :status, :category_id, :scene_id)
  end
end
