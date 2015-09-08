FactoryGirl.define do
  factory :choice do
    label { FFaker::Name.name }
    votes 0
    poll
  end

end
