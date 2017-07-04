class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_one :image, as: :imageable

  accepts_nested_attributes_for :image, reject_if: :all_blank, allow_destroy: true

  validates :content, presence: true

  default_scope -> {order(created_at: :desc)}
end
