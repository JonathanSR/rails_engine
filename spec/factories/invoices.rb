FactoryGirl.define do
  factory :invoice do
    customer 
    merchant 
    status "shipped"
    created_at "2014-11-07T12:12:12.000Z"
    updated_at "2014-11-07T12:12:12.000Z"

  end
end
