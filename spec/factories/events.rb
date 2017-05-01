require 'faker'

FactoryGirl.define do
  factory :event do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    location { Faker::Lorem.word }
    time { Faker::Time.between(10.days.ago, 5.days.from_now) }
    user_id { FactoryGirl.create(:user).id }
  end
end