class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.items_most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.success)
    .group('items.id')
    .select('sum(invoice_items.quantity * invoice_items.unit_price) as total, items.merchant_id, items.unit_price, items.id, items.name, items.description')
    .order('total DESC')
    .limit(quantity)
  end
end
