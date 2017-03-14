class DropInvoicesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoices, :created_at, :timestamp
    remove_column :invoices, :updated_at, :timestamp
  end
end
