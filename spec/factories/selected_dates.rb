FactoryBot.define do
  factory :selected_date do
    dateString { "2025-03-13" }
    date { "2025-03-13" }
    numberDay { 4 }
    hour { "10:00" }
    association :schedule
  end
end
