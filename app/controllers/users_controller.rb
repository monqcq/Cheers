class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to my_page_users_path
    end
    @posts = Post.where(user_id: params[:id])
  end

  def my_page
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to my_page_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :favorite_alcohol, :introduction, :profile_image)
  end
end
