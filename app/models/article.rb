class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true#, length: {minimum: 50 ,maximum: 200}
  validates :body, presence: true
end
