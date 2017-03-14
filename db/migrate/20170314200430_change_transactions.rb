class ChangeTransactions < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :created_at, :timestamp
    remove_column :transactions, :updated_at, :timestamp
  end
end
