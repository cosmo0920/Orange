# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
		title { Forgery::Basic.text }
		isbn { "9784274068669" }
		description { Forgery::Basic.text }
  end
end
