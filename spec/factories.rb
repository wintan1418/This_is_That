FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { "password123" }

    trait :with_places do
      after(:create) do |user|
        create_list(:place, 3, user: user)
      end
    end
  end

  factory :category do
    name { Faker::Coffee.blend_name }
    yelp_alias { Faker::Lorem.unique.word }
  end

  factory :place do
    name { Faker::Coffee.blend_name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { "USA" }
    association :category
    rating { 4.5 }
    price { "$$" }
    image_url { "https://example.com/image.jpg" }
    user
    is_home_place { true }
    yelp_reviews_count { 5 }
    is_favorite { false }

    trait :match do
      is_home_place { false }
    end
  end

  factory :notification do
    title { "New Notification" }
    message { "Something happened" }
    notification_type { "info" }
    user
  end
end
