class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'

  validates_uniqueness_of :requested_id, scope: :requester_id
end
