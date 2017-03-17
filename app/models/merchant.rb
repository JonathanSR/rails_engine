class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

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


  def revenue(date)
    invoices_by_date(date).joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end


  def invoices_by_date(date)
    if date
      invoices.where(created_at: Time.zone.parse(date))
    else
      invoices
    end
end


  def self.total_revenue(date)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.success)
    .where(invoices:{created_at:(date)})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

end
