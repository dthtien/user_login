class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  validates :content, presence:  true

  default_scope -> {order(created_at: :desc)}

  def count_comments
    comments.count
  end

  def count_images
    images.count
  end
end
