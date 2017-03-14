class AddTimestampsToCustomers < ActiveRecord::Migration[5.0]
  def change
    change_table(:customers) { |t| t.timestamps precision: 0}
  end
end
