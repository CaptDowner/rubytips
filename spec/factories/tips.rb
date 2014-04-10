# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tip do
    source "MyString"
    rubytype "MyString"
    subject "MyString"
    category "MyString"
    tip "MyText"
    applies_to "MyString"
    email "MyString"
    posted "2014-04-01 13:06:03"
    firstname "MyString"
    lastname "MyString"
    xmail "MyString"
  end
end
