class AddInquiryToConversation < ActiveRecord::Migration[6.0]
  def change
    add_reference :conversations, :inquiry, null: true
  end
end
