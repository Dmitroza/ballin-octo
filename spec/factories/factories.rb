require 'factory_girl'

FactoryGirl.define do
  
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password "12345678"
    password_confirmation "12345678"    
  end

  factory :admin, class: User do
    email "admin@example.com"
    password "12345678"
    password_confirmation "12345678"   
    role "ADMIN"
  end

  factory :property do
    city "Sevastopol"
    street_name "b.Morskaya"
    street_number "23"  
  end

end