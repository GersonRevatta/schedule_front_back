FactoryBot.define do
  factory :schedule do
    startDate { Time.current + 1.day }
    endDate { Time.current + 2.days }
  end
end
