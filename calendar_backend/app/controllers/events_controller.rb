# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    # events = Event.where(:calendar_id => params[:calendar_id])
    # byebug
    
    render json: EventSerializer.new(Event.where(:calendar_id => params[:user_id])).to_serialized_json
  end

  def create
    begin
      updated_time = nil
      begin
        updated_time = DateTime.parse(params[:event_time])
      rescue ArgumentError
        render json: {
          errors: {
            message: "DateTime.parse raised ArgumentError. Are we passing a valid date to the backend?",
            errors: ArgumentError,
          },
        }
        return
      end
      byebug
      event = Event.create!(
        title: params[:title],
        description: params[:description],
        event_tag: params[:event_tag],
        calendar_id: @user.calendar_id,
        event_time: updated_time,
      )
      # render json: EventSerializer.new(event).to_serialized_json
      render json: event.as_json(
        except: [:calendar_id, :updated_at, :created_at],
      ), status: :created
      return
    rescue ActiveRecord::RecordInvalid => invalid
      render json: {
        errors: {
          message: "ActiveRecord::RecordInvalid!",
          errors: invalid.record.errors,
        },
      }
    end
  end

  def update
    event = Event.find_by(title: params[:eventToBeDropped][:title])
    begin
      event.update!(event_time: params[:new_event_time])
      render json: event.as_json(
        except: [:calendar_id, :updated_at, :created_at],
      )
    rescue ActiveRecord::RecordInvalid => invalid
      render json: {
        errors: {
          message: "ActiveRecord::RecordInvalid",
          errors: invalid.record.errors,
        }
      }
    end
  end

  def delete
    begin
      event = Event.find_by!(id: params[:id])
      deleted = event.delete
      render json: deleted.as_json(
        only: :id
      )
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        errors: {
          message: 'ActiveRecord::RecordNotFound',
          errors: e
        }
      }
    end
  end
end
