class MerchantsRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object / 100.00).to_s
  end
end
