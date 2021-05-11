class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def my_page
    @user = current_user
  end

  def edit
  end

  def update
  end
end
