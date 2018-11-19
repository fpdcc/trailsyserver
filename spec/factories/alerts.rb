FactoryBot.define do
    factory :alert do
      alert_type { "alert" }
      origin_type { "Pointsofinterest" }
      description { "Test Alert" }
      starts_at { "2018-10-01" }
    end
  end