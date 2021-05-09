# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    callback_for(:facebook)
  end
  
  def google_oauth2
    callback_for(:google)
  end
  
  def failure
    redirect_to root_path and return
  end
  
  private
  
  def callback_for(provider)
    # APIから取得したユーザー情報はrequest.env['omniauth.auth']に格納されている
    @omniauth = request.env['omniauth.auth']
    # User.find_oauthはモデルで定義
    info = User.find_oauth(@omniauth)
    # deviseのヘルパーを使うために@userに代入
    @user = info[:user]
    # ユーザー登録済みの処理
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_massege(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    # ユーザー未登録の処理
    else
      @sns = info[:sns]
      render template: "devise/registrations/new"
    end
  end
  
end
