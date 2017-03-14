FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number 123
    credit_card_expiration_date "2017-03-13"
    result "success"
    created_at "2014-11-07T12:12:12.000Z"
    updated_at "2014-11-07T12:12:12.000Z"
  end
end
