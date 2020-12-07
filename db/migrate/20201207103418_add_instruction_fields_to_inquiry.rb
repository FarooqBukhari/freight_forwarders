class AddInstructionFieldsToInquiry < ActiveRecord::Migration[6.0]
  def change
    #Inquiry Table
    add_column :inquiries, :special_instructions, :text, default: ""
    add_column :inquiries, :transport_mode, :string, default: 0
    add_column :inquiries, :item_type, :string, default: 0
    add_column :inquiries, :inco_terms, :string, default: 0
    add_column :inquiries, :need_custom_clearance, :boolean, default: false
    add_column :inquiries, :is_hazardous, :boolean, default: false
    add_column :inquiries, :is_personal, :boolean, default: false

    #User Table
    add_column :users, :company_name, :string, default: ""
    add_column :users, :country, :string, default: ""
  end
end
