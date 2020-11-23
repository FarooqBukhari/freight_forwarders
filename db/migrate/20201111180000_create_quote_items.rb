class CreateQuoteItems < ActiveRecord::Migration[6.0]
  def change
    create_table :quote_items do |t|
      t.string :name, null: false
      t.string :item_type, null: false
      t.float :amount, null: false
      t.string :routing
      t.references :quote, foreign_key: true
      t.timestamps
    end
    add_column :quote_items, :deleted_at, :datetime
    add_index :quote_items, :deleted_at
  end
end
