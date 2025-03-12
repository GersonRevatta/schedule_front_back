class Schedule < ApplicationRecord
  has_many :selected_dates, dependent: :destroy
  accepts_nested_attributes_for :selected_dates

  validate :start_date_must_be_before_end_date
  validate :schedule_repeated
  validate :schedule_on_past

  private

  def start_date_must_be_before_end_date
    if startDate.present? && endDate.present? && startDate > endDate
      errors.add(:startDate, "no puede ser mayor que endDate")
    end
  end

  def schedule_repeated
    return unless startDate.present? && endDate.present?

    schedules = Schedule.where("startDate = ? AND endDate = ?", startDate, endDate)

    if schedules.exists?
      errors.add(:base, "Agendamiento ya existe")
    end
  end

  def schedule_on_past
    if startDate.present? && startDate < Time.current
      errors.add(:startDate, "no puede ser una fecha pasada")
    end
  end
end
