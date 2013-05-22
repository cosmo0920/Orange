# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
		title { Forgery::Basic.text }
		isbn { Forgery::Basic.text }
		description { Forgery::Basic.text }
  end
end
