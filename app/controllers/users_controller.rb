class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to my_page_users_path
    end
    @posts = Post.where(user_id: params[:id]).page(params[:page]).per(9)
  end

  def my_page
    @user = current_user
    @posts = @user.posts.published.all.page(params[:page]).per(9)
  end

  def likes
    @user = User.find(params[:id])
    @liked_posts = @user.liked_posts.page(params[:page]).per(6)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :favorite_alcohol, :introduction, :profile_image)
  end
end
