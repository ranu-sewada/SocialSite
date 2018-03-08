class Status < ApplicationRecord
  belongs_to :post
  belongs_to  :user
  validates :post_id, uniqueness: { scope: [:user_id, :like] }
end
