class Profile < ApplicationRecord
  belongs_to :user, optional: true

  delegate :full_name, :email, :posts, :image_url, to: :user
end
