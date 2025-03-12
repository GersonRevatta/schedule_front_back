class Schedule < ApplicationRecord
  has_many :selected_dates, dependent: :destroy
  accepts_nested_attributes_for :selected_dates
end
