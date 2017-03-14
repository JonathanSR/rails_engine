FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number 123
    credit_card_expiration_date "2017-03-13"
    result "success"
  end
end
