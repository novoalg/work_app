FactoryGirl.define do
    factory :user do
        username "Example User"
        email "email@example.com"
        password "foobar"
        password_confirmation "foobar"
    end
end
