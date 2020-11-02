class CreateInquiryItem < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiry_items do |t|
      t.string :commodity, null: false
      t.integer :number_of_units, null: false
      t.float :length, null: false
      t.float :width, null: false
      t.float :heigth, null: false
      t.float :weight, null: false
      t.references :inquiry, foreign_key: true
      t.timestamps
    end
  end
end
