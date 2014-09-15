# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	first_name 'Birhanu'
  	second_name 'Hailemariam'
  	sequence(:email) { |n| "email#{n}gmail.com"}
  	password 'pw' 
  end
end
