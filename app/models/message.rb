class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  acts_as_readable on: :created_at
  after_create_commit { MessageBroadcastJob.perform_later(self) }

end
