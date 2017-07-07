class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, :friend_id, presence: true

  enum status: [ :pending, :requested, :accepted, :blocked ] 

  # Class method
  class << self
    def relation_attributes(user, friend, status: nil)
      attr = {
        user_id: user.id,
        friend_id: friend.id
      }

      attr[:status] = status if status

      attr
    end

    def find_relation(user, friend, status: nil )
      where( relation_attributes(user, friend, status: status) )
    end

    def exist?(user, friend)
      find_relation(user, friend).any? && find_relation(friend, user).any?
    end

    def create_relation(user, friend, options)
      relation = new relation_attributes(user, friend)
      relation.attributes = options
      relation.save
    end

    def find_unblocked_friendship(user, friend)
      find_relation(user, friend).where.not(status: 3).first
    end

     def find_blocked_friendship(user, friend)
      find_relation(user, friend).where(status: 3).first
    end

  end

  #Instance method
  def accept!
    self.status = 2
    self.save
  end

  def block
    self.status = 3
    self.save
  end

end
