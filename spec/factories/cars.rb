# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :car do
    color "Black"
    year 2010
    mileage 29000
    description "This car is awesome!"

    trait :no_description do
      description ""
    end
  end
end
