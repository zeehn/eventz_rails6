class EventsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  
  def index
    case params[:filter]
    when 'past'
      @events = Event.past_events
    when 'free'
      @events = Event.free_events
    when 'recent'
      @events = Event.recent_events
    else
      @events = Event.upcoming_events
    end
  end

  def new 
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event successfully created!"
      redirect_to @event 
    else
      render :new 
    end
  end

  def show
    @users = @event.users
    @categories = @event.categories
    if current_user 
      @like = current_user.likes.find_by(event_id: @event.id)
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event successfully updated!"
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy 
    if @event.destroy
      flash[:alert] = "Event deleted successfully!" 
      redirect_to events_path 
    end 
  end

  private
  def set_event
    @event = Event.find_by!(slug: params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :location, :price, :starts_at, :capacity, :image_file_name, category_ids: [])
  end
end