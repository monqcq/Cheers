class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # OmniAuthを使うためのオプション
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # プロフィール画像をアップロードするための記述
  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # いいねしている投稿を取得するアソシエーション
  has_many :liked_posts, through: :likes, source: :post
  
  # ユーザーがすでにいいねをしているか判断するメソッド
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
  
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 100 }
  validates :favorite_alcohol, length: { maximum: 30 }
end
