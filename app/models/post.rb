class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  # 投稿画像をアップロードするための記述
  attachment :image
  
end
