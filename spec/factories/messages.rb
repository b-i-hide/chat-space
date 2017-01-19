FactoryGirl.define do
  factory :message do
    body { Faker::Lorem.sentence }
    # image { fixture_file_upload('spec/fixture/img/sample.JPG') }
  end
end
