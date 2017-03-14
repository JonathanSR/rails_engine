FactoryGirl.define do
  factory :invoice do
    customer 
    merchant 
    status "shipped"
    #created_at "2016"
  end
end
