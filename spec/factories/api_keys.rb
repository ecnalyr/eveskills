# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_key do
    id "MyString"
    verification_code "MyString"
    user nil
  end
end
