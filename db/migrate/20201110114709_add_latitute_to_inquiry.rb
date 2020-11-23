class AddLatituteToInquiry < ActiveRecord::Migration[6.0]
  def change
    add_column :inquiries, :origin_lat, :decimal, {:precision=>10, :scale=>6}
    add_column :inquiries, :origin_lng, :decimal, {:precision=>10, :scale=>6}
    add_column :inquiries, :destination_lat, :decimal, {:precision=>10, :scale=>6}
    add_column :inquiries, :destination_lng, :decimal, {:precision=>10, :scale=>6}
  end
end
