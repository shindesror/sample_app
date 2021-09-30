FactoryBot.define do
  factory :purchase_order do
    client_name { 'MyString' }
    amount { '9.99' }
    tax { '9.99' }
    vendor { 'MyString' }
  end
end
