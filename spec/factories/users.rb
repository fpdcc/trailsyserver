FactoryBot.define do
    factory :user do
        email { "user@test.com" }
        admin { true }
        approved { true }
        password { "Password1$%" }
        password_confirmation { "Password1$%" }
        trait :level1 do
            after(:create) {|user| user.role = "level1"}
          end
          trait :level2 do
            after(:create) {|user|  user.role = "level2"}
          end
          trait :admin do
            after(:create) {|user|  user.role = "admin"}
          end
    end
end