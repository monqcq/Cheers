class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # ひとりが１つの投稿に対して一回しかいいねができないバリデーション
  validates_uniqueness_of :post_id, scope: :user_id
end
