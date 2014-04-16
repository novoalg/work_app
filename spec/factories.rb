FactoryGirl.define do
    factory :user do
        sequence(:username) { |n| "Person #{n}" }
        sequence(:email) { |n| "person_#{n}uwec.edu" }
    end
end
