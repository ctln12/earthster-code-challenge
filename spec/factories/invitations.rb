FactoryBot.define do
  factory :invitation do
    email { "MyString" }
    message { "MyText" }
    cycle { nil }
  end
end
