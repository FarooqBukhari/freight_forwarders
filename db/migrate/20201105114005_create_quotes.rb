class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.float :price, null: false
      t.references :inquiry, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_column :quotes, :deleted_at, :datetime
    add_index :quotes, :deleted_at
  end
end
