FactoryGirl.define do
  factory :customer do
    sequence :first_name do |n|
      "FirstName#{n}"
    end
    sequence :last_name do |n|
      "LastName#{n}"
    end
  end
end
