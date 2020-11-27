class LikesController < ApplicationController
  before_action :require_signin

  def create 
    @event = Event.find(params[:event_id])
    @event.likes.new(user: current_user)
    if @event.save 
      redirect_to @event
    end
  end

  def destroy 
    event = Event.find(params[:event_id])
    like = current_user.likes.find(params[:id])
    like.destroy
    redirect_to event
  end
end