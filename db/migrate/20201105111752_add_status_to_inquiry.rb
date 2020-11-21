class AddStatusToInquiry < ActiveRecord::Migration[6.0]
  def change
    add_column :inquiries, :status, :string, default: Inquiry.statuses[:pending]
  end
end
