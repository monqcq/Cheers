class Post < ApplicationRecord
  belongs_to :user
  # 投稿画像をアップロードするための記述
  attachment :image
end
