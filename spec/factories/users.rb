FactoryGirl.define do
  factory :user do
    name {Faker::StarWars.character}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(8, 15)}
  end
end
