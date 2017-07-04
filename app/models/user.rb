class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  after_create :create_profile

  validates :last_name, :first_name, presence: true, length: {maximum: 50}
  validates :email, presence: true, 
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
    uniqueness: true
  validates :password, presence: true, length: {minimum: 6}

  before_save :downcase_email

  def full_name
    first_name + ' ' + last_name
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def author?(record)
    record.user == self
  end

  def edit_profile?
    profile.updated_at == profile.created_at
  end

  def image_url
    "https://yt3.ggpht.com/-E2JOWZf82_c/AAAAAAAAAAI/AAAAAAAAAAA/5TIL33FTKF0/s900-c-k-no-mo-rj-c0xffffff/photo.jpg"
  end

  private 
    def downcase_email
      self.email = email.downcase 
    end
end
