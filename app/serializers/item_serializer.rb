class ItemSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :name, :unit_price, :description

  def unit_price
    (object.unit_price / 100.00).to_s
  end
end
