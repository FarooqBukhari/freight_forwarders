class Friendship < ApplicationRecord
  belongs_to :friender, class_name: 'User', foreign_key: :friendable_id
  belongs_to :friended, class_name: 'User', foreign_key: :friend_id

  def other_user(user)
    self.friender == user ? friended : friender
  end
end