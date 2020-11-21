class AddDeletedAtToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :inquiries, :deleted_at, :datetime
    add_index :inquiries, :deleted_at

    add_column :inquiry_items, :deleted_at, :datetime
    add_index :inquiry_items, :deleted_at
  end
end
