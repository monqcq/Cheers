class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  # 投稿画像をアップロードするための記述
  attachment :image
  
  enum status: { draft: 0, published: 1 }
  validates :status, inclusion: { in: Post.statuses.keys }

end
