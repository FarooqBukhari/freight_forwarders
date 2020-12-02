class AddQuoteToConversation < ActiveRecord::Migration[6.0]
  def change
    add_reference :conversations, :quote, null: true
  end
end
