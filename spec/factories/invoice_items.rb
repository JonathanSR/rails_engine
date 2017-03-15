FactoryGirl.define do
  factory :invoice_item do
    item 
    invoice 
    quantity 1
    unit_price 1
    created_at "2014-11-07T12:12:12.000Z"
    updated_at "2014-11-07T12:12:12.000Z"
  end
end
