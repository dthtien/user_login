class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy

  paginates_per 5

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  validate :have_content_or_image

  default_scope -> {order(created_at: :desc)}

  private
    def have_content_or_image
      if self.content.blank? && self.images.blank?
        errors.add(:content, "This post must have content or image")
      end
    end
end
