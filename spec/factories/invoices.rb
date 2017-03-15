FactoryGirl.define do
  factory :invoice do
    customer 
    merchant 
    status "shipped"
    created_at "2014-11-07T12:12:12.000Z"
    updated_at "2014-11-07T12:12:12.000Z"
    

      factory :invoice_with_transactions do
      transient do
        transaction_count 3
      end

        after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transaction_count, invoice: invoice)
      end
    end

      factory :invoice_with_invoice_items do
      transient do
        invoice_item_count 3
      end

        after(:create) do |invoice, evaluator|
        create_list(:invoice_item, evaluator.invoice_item_count, invoice: invoice)
      end
    end
  end
end