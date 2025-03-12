require 'rails_helper'

RSpec.describe SelectedDate, type: :model do
  describe 'Asociaciones' do
    it { should belong_to(:schedule) }
  end
end
