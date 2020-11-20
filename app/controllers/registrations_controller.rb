class RegistrationsController < ApplicationController 
  def index
    @event = Event.find(1)
    @registrations = @event.registrations
  end 
  
end