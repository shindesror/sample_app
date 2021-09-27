FactoryBot.define do
  factory :invoice do
    client_name { 'John Smith' }
    amount { 100 }
    tax { 12 }
  end
end
