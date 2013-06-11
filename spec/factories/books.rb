# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  isbn_sequence =%w(
    9784274068669 9784797363821 9784797347784 9781934356371 978-4797357400
    4797357401    9784797372274 4797372273    9784774155074 4774155071
    9784774156071 4774156078    9784774157191 4774157198)

  factory :book do
    title { Forgery::Basic.text }
    sequence(:isbn) {|n| "#{isbn_sequence[n % isbn_sequence.length]}" }
    image_url { Forgery::Basic.text }
  end
end
