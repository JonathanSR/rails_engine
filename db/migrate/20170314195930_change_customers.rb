class ChangeCustomers < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :created_at, :timestamp
    remove_column :customers, :updated_at, :timestamp
  end
end
