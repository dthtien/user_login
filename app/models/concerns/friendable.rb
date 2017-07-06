module Concerns
  module Friendable
    extend ActiveSupport::Concern

    included do
      has_many :friendships, class_name: "Friendship", dependent: :destroy

      has_many :blocked_friends,
                -> { where friendships: { status: 3 } },
                through: :friendships,
                source: :friend

      has_many :friends,
                -> { where friendships: { status: 2 } },
                through: :friendships

      has_many :requested_friends,
                -> { where friendships: { status: 1 } },
                through: :friendships,
                source: :friend

      has_many :pending_friends,
                -> { where friendships: { status: 0 } },
                through: :friendships,
                source: :friend
    end

    def friend_request(friend)
      if self != friend && !Friendship.exist?(self, friend)
        Friendship.create_relation(self, friend, status: 0)
        Friendship.create_relation(friend, self, status: 1)
      end 
    end

    def accept_request(friend)
      friendship = Friendship.find_unblocked_friendship(self, friend)
      friendship.accept! if can_accept_request?(friendship)

      friendship2 = Friendship.find_unblocked_friendship(friend, self)
      friendship2.accept! if can_accept_request?(friendship2)
    end

    def decline_request(friend)
      Friendship.find_unblocked_friendship(self, friend).destroy

      Friendship.find_unblocked_friendship(friend, self).destroy
    end

    alias_method :remove_friend, :decline_request

    def friend_with?(friend)
      friends.include? friend
    end

    def pending_friend_with?(friend)
      pending_friends.include? friend
    end

    def requested_friend_with?(friend)
      requested_friends.include? friend
    end

    private
      def can_accept_request?(friendship)
        return if friendship.pending? && self == friendship.user
        return if friendship.requested? && self == friendship.friend

        true
      end

  end
end