# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    # APIから取得したユーザー情報はrequest.env['omniauth.auth']に格納されている
    # User.from_omniauthはuserモデルに記述
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # ユーザー登録済みの処理
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_massege(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    # ユーザー未登録の処理
    else
      session['devise.#{provider}_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
