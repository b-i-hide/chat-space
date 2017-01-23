FactoryGirl.define do
  factory :chat_group do
    name { Faker::Team.name }
  end
end
