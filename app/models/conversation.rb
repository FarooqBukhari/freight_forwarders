class Conversation < ApplicationRecord
  enum :con_type => {"User": 1, "Inquiry": 2, "Quote": 3}

  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
  belongs_to :inquiry, foreign_key: :inquiry_id, required: false
  belongs_to :quote, foreign_key: :inquiry_id, required: false
  validates :sender_id, uniqueness: { scope: [:recipient_id, :con_type] }

  scope :between, -> (sender_id, recipient_id, con_type, inquiry_id, quote_id) do
    where(sender_id: sender_id, recipient_id: recipient_id, con_type: con_type, inquiry_id: inquiry_id, quote_id: quote_id).or(
        where(sender_id: recipient_id, recipient_id: sender_id, con_type: con_type, inquiry_id: inquiry_id, quote_id: quote_id)
    )
  end

  def self.get(sender_id, recipient_id, con_type, inquiry_id, quote_id)
    conversation = between(sender_id, recipient_id, con_type, inquiry_id, quote_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id, con_type: con_type, inquiry_id: inquiry_id, quote_id: quote_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end
end
