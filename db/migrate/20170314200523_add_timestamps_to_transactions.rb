class AddTimestampsToTransactions < ActiveRecord::Migration[5.0]
  def change
    change_table(:transactions) { |t| t.timestamps precision: 0}
  end
end
