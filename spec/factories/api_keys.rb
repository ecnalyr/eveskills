# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_key do
    eve_api_identifier "MyString"
    verification_code "MyString"
    user
  end
end
