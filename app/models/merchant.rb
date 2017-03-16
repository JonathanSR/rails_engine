class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.customers_with_pending_invoices
    joins(:invoices, :customer).where(invoice:{status:"pending"})
  end 

  def favorite_customer
    customers.joins(invoices: [:transactions])
    .merge(Transaction.success)
    .group('customers.id')
    .order('count(invoices.merchant_id) DESC')
    .first
  end

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.success)
    .group('merchants.id')
    .select('sum(quantity * unit_price) as total, merchants.id, merchants.name')
    .order('total DESC')
    .limit(quantity)
  end
end
  