class Conversation < ApplicationRecord
  enum :con_type => {"User": 1, "Inquiry": 2}

  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
  belongs_to :inquiry, foreign_key: :inquiry_id, required: false
  validates :sender_id, uniqueness: { scope: [:recipient_id, :con_type] }

  scope :between, -> (sender_id, recipient_id, con_type) do
    where(sender_id: sender_id, recipient_id: recipient_id, con_type: con_type).or(
        where(sender_id: recipient_id, recipient_id: sender_id, con_type: con_type)
    )
  end

  def self.get(sender_id, recipient_id, con_type)
    conversation = between(sender_id, recipient_id, con_type).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id, con_type: con_type)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end
end
