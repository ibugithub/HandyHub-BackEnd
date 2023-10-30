FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    jti { SecureRandom.uuid }
    role { 'user' }
  end
end
