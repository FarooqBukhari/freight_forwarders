class Friendship < ApplicationRecord
  belongs_to :friender, class_name: 'User', foreign_key: :friendable_id
  belongs_to :friended, class_name: 'User', foreign_key: :friend_id
end