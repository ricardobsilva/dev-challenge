class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :create_friendship_bi
  after_destroy :finish_friendship_bi

  def create_friendship_bi
    friend.friends << user unless friend.friends.include?(user)
  end

  def finish_friendship_bi
    friend.friends.delete(user)
  end

end
