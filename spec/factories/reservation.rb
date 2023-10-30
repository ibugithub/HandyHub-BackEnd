FactoryBot.define do
  factory :reservation do
    city { 'city' }
    date { Date.today }
    user { association :user }
    trade { association :trade }
  end
end
