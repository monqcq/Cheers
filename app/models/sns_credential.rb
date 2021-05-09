class SnsCredential < ApplicationRecord
  # optional: trueでidのnilを許可
  belongs_to :user, optional: true
end
