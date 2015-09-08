FactoryGirl.define do
  factory :poll do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.sentences }
    user
    choices_attributes { [FactoryGirl.attributes_for(:choice), FactoryGirl.attributes_for(:choice), FactoryGirl.attributes_for(:choice)] }

    trait :with_many_choices do 
      choices_attributes { [
        FactoryGirl.attributes_for(:choice), FactoryGirl.attributes_for(:choice), 
        FactoryGirl.attributes_for(:choice), FactoryGirl.attributes_for(:choice), 
        FactoryGirl.attributes_for(:choice), FactoryGirl.attributes_for(:choice)
      ] }
    end

    trait :with_invalid_choices do 
      choices_attributes { [FactoryGirl.attributes_for(:choice), FactoryGirl.attributes_for(:choice), FactoryGirl.attributes_for(:choice, label: '')] }
    end

    trait :with_lack_of_choices do 
      choices_attributes { [FactoryGirl.attributes_for(:choice)] }
    end

    trait :without_choices do 
      choices_attributes { [] }
    end
  end
end
