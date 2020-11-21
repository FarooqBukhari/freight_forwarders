class CreateInquiry < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries do |t|
      t.string :origin_location_type, null: false
      t.string :origin_country, null: false
      t.string :origin_address, null: false
      t.string :destination_location_type, null: false
      t.string :destination_country, null: false
      t.string :destination_address, null: false
      t.date :goods_ready_date, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
