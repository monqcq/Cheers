class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
        # OmniAuthを使うためのオプション
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
         
  has_many :sns_credential, dependent: :destroy
  
end
