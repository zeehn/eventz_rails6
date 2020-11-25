class RegistrationsController < ApplicationController 
  before_action :require_signin

  def index
    @event = Event.find(params[:event_id])
    @registrations = @event.registrations
  end 
  
  def new 
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.new
  end

  def create 
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.new(registration_params)
    @registration.user = current_user
    if @registration.save
      flash[:notice] = "Thanks for registering!"
      redirect_to event_registrations_path
    else
      render :new 
    end
  end

  private 
  def registration_params
    params.require(:registration).permit(:how_heard)
  end
end