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
          endDate: Time.current + 1.day # startDate mayor a endDate
        }
      }
    end

    context 'cuando los parámetros son válidos' do
      it 'crea un nuevo schedule' do
        expect {
          post :create, params: valid_params, format: :json
        }.to change(Schedule, :count).by(1)
      end

      it 'devuelve el schedule creado con estado HTTP 201' do
        post :create, params: valid_params, format: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'cuando los parámetros son inválidos' do
      it 'no crea un nuevo schedule' do
        expect {
          post :create, params: invalid_params, format: :json
        }.not_to change(Schedule, :count)
      end

      it 'devuelve errores con estado HTTP 422' do
        post :create, params: invalid_params, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
