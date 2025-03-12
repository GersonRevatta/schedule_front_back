require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'relations' do
    it { should have_many(:selected_dates).dependent(:destroy) }
  end

  describe 'validations' do
    subject { Schedule.new(startDate: Time.current + 1.day, endDate: Time.current + 2.days) }

    it 'range valid' do
      schedule = Schedule.new(startDate: Time.current + 2.days, endDate: Time.current + 1.day)
      expect(schedule.valid?).to be false
      expect(schedule.errors[:startDate]).to include("no puede ser mayor que endDate")
    end

    it 'schedule duplicated' do
      existing_schedule = Schedule.create!(startDate: Time.current + 1.day, endDate: Time.current + 2.days)
      duplicate_schedule = Schedule.new(startDate: existing_schedule.startDate, endDate: existing_schedule.endDate)

      expect(duplicate_schedule.valid?).to be false
      expect(duplicate_schedule.errors[:base]).to include("Agendamiento ya existe")
    end

    it 'schedule on past' do
      past_schedule = Schedule.new(startDate: Time.current - 1.day, endDate: Time.current + 1.day)

      expect(past_schedule.valid?).to be false
      expect(past_schedule.errors[:startDate]).to include("no puede ser una fecha pasada")
    end
  end
end
