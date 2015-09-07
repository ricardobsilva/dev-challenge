class AddAprovedToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :aproved, :string
  end
end
