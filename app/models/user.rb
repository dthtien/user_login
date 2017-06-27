class User < ApplicationRecord
  has_secure_password

  validates :last_name, :first_name, presence: true, length: {maximum: 50}
  validates :email, presence: true, 
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
    uniqueness: true
  validates :password, presence: true, length: {maximum: 6}

  before_save :downcase_email

  def full_name
    first_name + ' ' + last_name
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  private 
    def downcase_email
      self.email = email.downcase 
    end
end
