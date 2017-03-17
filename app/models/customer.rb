class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices

  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.joins(invoices: [:transactions])
    .merge(Transaction.success)
    .group('merchants.id')
    .order('count(invoices.customer_id) DESC')
    .first
  end
end
