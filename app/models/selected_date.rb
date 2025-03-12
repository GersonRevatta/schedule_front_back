class SelectedDate < ApplicationRecord
  belongs_to :schedule, inverse_of: :selected_dates
end
