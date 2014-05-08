class EventsController < ApplicationController
  filter_resource_access
  respond_to :html

  def index
    @events = Event.with_permissions_to(:index).page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    @cal = Calendar.new("insert", Event.first).call
    # params[:event][:attendees] = params[:event][:attendees].split(',')
    # if @event.save
    #   @cal = Calendar.new("insert", Event.first).call
    #   flash[:notice] = "#{@event} created."
    # else
    #   render :new
    # end
  end

  def edit
  end

  def update
    if @event.update events_params
      assign_groups(params)
      flash[:notice] = "#{@event} updated. This page will refresh once the recipients are found."
      redirect_to @event
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = "#{@event} has been deleted."
    redirect_to events_path
  end

  private

  def new_event_from_params
    @event = Event.new(events_params)
  end

  def events_params
    params[:event].permit(:title, :starts_at, :ends_at, :description, :location, :visibility, :attendees, :user_id) if params[:event]
  end
end