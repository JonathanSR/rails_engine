FactoryGirl.define do
  factory :customer do
    sequence :first_name do |n|
      "FirstName#{n}"
    end
    sequence :last_name do |n|
      "LastName#{n}"
    end
    created_at "2014-11-07T12:12:12.000Z"
    updated_at "2014-11-07T12:12:12.000Z"
  end
end
