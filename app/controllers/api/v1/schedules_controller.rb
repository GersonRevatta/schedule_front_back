class Api::V1::SchedulesController < Api::V1::ApplicationController

  def create
    schedule = Schedule.new(schedule_params.except(:selectedDates))
    if schedule.save    
      if params[:selectedDates].present?
        params[:selectedDates].each do |date_params|
          schedule.selected_dates.create(date_params.permit(:dateString, :date, :numberDay, :hour))
        end
      end
      render json: schedule, include: :selected_dates, status: :created
    else
      render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:startDate, :endDate,
      selectedDates: [:dateString, :date, :numberDay, :hour])
  end
end