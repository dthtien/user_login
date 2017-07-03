class Image < ApplicationRecord
  has_attached_file :image_upload, styles: {original: "300x300>"}, default_url: "https://yt3.ggpht.com/-E2JOWZf82_c/AAAAAAAAAAI/AAAAAAAAAAA/5TIL33FTKF0/s900-c-k-no-mo-rj-c0xffffff/photo.jpg"
  validates_attachment_content_type :image_upload, content_type: /\Aimage\/.*\z/

  belongs_to :imageable, polymorphic: true, optional: true

end
