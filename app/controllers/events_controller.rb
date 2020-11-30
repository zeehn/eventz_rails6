class EventsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  
  def index
    case params[:filter]
    when 'past'
      @events = Event.past
    when 'free'
      @events = Event.free_events
    when 'recent'
      @events = Event.recent
    else
      @events = Event.upcoming
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
    @event = Event.find(params[:id])
    @users = @event.users
    @categories = @event.categories
    if current_user 
      @like = current_user.likes.find_by(event_id: @event.id)
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "Event successfully updated!"
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy 
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:alert] = "Event deleted successfully!" 
      redirect_to events_path 
    end 
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :location, :price, :starts_at, :capacity, :image_file_name, category_ids: [])
  end
end