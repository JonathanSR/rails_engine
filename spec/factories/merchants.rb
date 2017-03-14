FactoryGirl.define do
  factory :merchant do
    sequence :name do |n|
      "Name#{n}"
    end
  end
end
