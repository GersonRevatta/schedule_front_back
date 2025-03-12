require 'rails_helper'
require 'pry'

RSpec.describe Api::V1::SchedulesController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) do
      {
        schedule: {
          startDate: Time.current + 1.day,
          endDate: Time.current + 2.days,
          selectedDates: [
            { dateString: "2025-03-13", date: "2025-03-13", numberDay: 4, hour: "10:00" }
          ]
        }
      }
    end

    let(:invalid_params) do
      {
        schedule: {
          startDate: Time.current + 2.days,
          endDate: Time.current + 1.day
        }
      }
    end

    context 'params valids' do
      it 'schedule success' do
        expect {
          post :create, params: valid_params, format: :json
        }.to change(Schedule, :count).by(1)
      end

      it 'schedule created' do
        post :create, params: valid_params, format: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'params invalids' do
      it 'schedule error' do
        expect {
          post :create, params: invalid_params, format: :json
        }.not_to change(Schedule, :count)
      end

      it 'schedule error' do
        post :create, params: invalid_params, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
