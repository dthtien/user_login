class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :content, presence:  true

  default_scope -> {order(created_at: :desc)}

  def count_comments
    comments.count
  end
end
