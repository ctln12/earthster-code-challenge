FactoryBot.define do
  factory :invitation do
    email { Faker::Internet.free_email }
    message { Faker::Lorem.sentence }
    cycle
  end
end
