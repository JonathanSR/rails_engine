class ItemSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :name, :unit_price, :description

  def unit_price
    object.unit_price.to_s.chars.insert(-3, ".").join
  end
end
