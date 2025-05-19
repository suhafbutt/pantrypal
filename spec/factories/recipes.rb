FactoryBot.define do
  factory :recipe do
    title { "Test Recipe" }
    prep_time { 10 }
    cook_time { 20 }
    ratings { 4.5 }
  end
end
