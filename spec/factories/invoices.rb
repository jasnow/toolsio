FactoryGirl.define do
  factory :invoice do
    customer "MyString"
    #date "2016-02-20 18:53:05"
    date_of_an_invoice "2016-02-20"
    trait :deadline do 
      deadline "2016-02-20"
    end
    trait :payment_term do 
      payment_term "2"
    end
    interest_on_arrears "9"
    reference_number "1234"
  end

end
