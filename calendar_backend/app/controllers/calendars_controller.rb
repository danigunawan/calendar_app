class CalendarsController < ApplicationController
  def show
    begin
      calendar = Calendar.find(params[:id])
      render json: CalendarSerializer.new(calendar).to_serialized_json
    rescue ActiveRecord::RecordNotFound => invalid
      render json: { errors: ["Calendar not found!", invalid] }
    end
  end
end
