class AddStatusToInquiry < ActiveRecord::Migration[6.0]
  def change
    add_column :inquiries, :status, :string
  end
end
