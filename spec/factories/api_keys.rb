# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_key do
    eve_api_identifier "MyString"
    verification_code "MyString"
    user

    trait :invalid_key do
      eve_api_identifier "MyString"
      verification_code "MyString"
    end

    trait :skill_is_training do
      eve_api_identifier "1867200"
      verification_code "oReWk9nG5QutSKn03RINpBXajnDtU2egla3uTr4dLQDV4kVTeQodWgy1He7ECeU4"
    end

    trait :skill_not_training do
      eve_api_identifier "1878387"
      verification_code "N918tK4e6MH1D6R61JjPuyxsylg9o2TIrdtuAK6mwhNW3zWy1KTZH7946jY2aV1L"
    end
  end
end
