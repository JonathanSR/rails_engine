class AddTimestampsColumnToInvoices < ActiveRecord::Migration[5.0]
  def change
     change_table(:invoices) { |t| t.timestamps precision: 0}
  end
end
