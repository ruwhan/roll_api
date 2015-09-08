FactoryGirl.define do
  factory :poll do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.sentences }
    user
  end
end
