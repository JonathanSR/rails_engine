FactoryGirl.define do
  factory :merchant do
    sequence :name do |n|
      "Name#{n}"
    end
    created_at "2014-11-07T12:12:12.000Z"
    updated_at "2014-11-07T12:12:12.000Z"
  end
end
