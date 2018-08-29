FactoryBot.define do
  factory :user do |user|
    user.first_name { "John" }
    user.last_name { "Doe" }
    user.email { "john@doe.com" }
    user.role { 2 }
    user.password { "abc123" }
    user.password_confirmation { "abc123" }

    trait :admin do
      role { 1 }
    end

    trait :inactive do
      role { 0 }
    end
=begin
    trait :password_match do
      user.password_confirmation { "abc123" }
    end
    
    trait :password_missmatch do
      user.password_confirmation { "abc1234" }
    end
=end
  end
end
