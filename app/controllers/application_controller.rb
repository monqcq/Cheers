class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  protected
  
  def after_sign_in_path_for(resource)
    posts_path 
  end
  
  def after_sign_up_path_for(resource)
    posts_path 
  end
  
  def set_search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result.published.order("created_at DESC").page(params[:page]).per(9)
    @search_word = @search.title_or_text_cont
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
