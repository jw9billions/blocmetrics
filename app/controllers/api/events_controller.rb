class API::EventsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:create]


  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

    if registered_application
      event = Event.new(event_params)
      event.registered_application = registered_application

      if event.save
        render json: event, status: :created
      else
        render json: {error: event.errors}, status: :unprocessable_entity
      end

    else
      render json: "Unregistered application", status: :unprocessable_entity
    end

  end

  def preflight
    head 200
  end

  private

    def event_params
      params.require(:event).permit(:name)
    end

end
