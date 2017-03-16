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

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.success)
    .group('merchants.id')
    .select("sum(quantity)as total, merchants.name, merchants.id")
    .order('total DESC')
    .limit(quantity)
  end


  # def total_revenue(quantity)
  #   Merchant.joins(:transactions, :invoice_items)
  #   .where(transactions: {result:"success"})
  #   .group(:id)
  #   .order("sum(quantity * unit_price)")
  #   .limit(quantity)
  # end
  
end
  