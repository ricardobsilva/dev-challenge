class AddFriendIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :friend_id, :integer
    add_index :messages, :friend_id
  end
end
