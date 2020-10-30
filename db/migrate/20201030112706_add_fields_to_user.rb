class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def self.up
    change_table :users do |t|
      t.string :name, null: false, default: ""
      t.string :phone, null: false, default: ""
      t.string :website, null: false, default: ""
      t.string :job_title, null: false, default: ""
    end
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :phone
    remove_column :users, :website
    remove_column :users, :job_title
  end
end
