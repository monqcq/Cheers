class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def my_page
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update
    redirect_to my_page_users_path
  end
  
end
