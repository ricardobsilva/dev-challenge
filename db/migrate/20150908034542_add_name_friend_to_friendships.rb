class AddNameFriendToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :name_friend, :string
  end
end
