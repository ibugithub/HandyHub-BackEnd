FactoryBot.define do
  factory :trade do
    name { 'MyString' }
    description { 'MyText' }
    location { 'MyString' }
    price { '9.99' }
    duration { 'MyString' }
    user { association :user }
  end
end
