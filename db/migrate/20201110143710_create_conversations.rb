class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.integer :con_type

      t.timestamps
    end
    add_index :conversations, [:recipient_id, :sender_id, :con_type], unique: true
  end
end
