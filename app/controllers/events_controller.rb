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
    new_calendar
    # if @event.save
    #   redirect_to @event
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

  def new_calendar
    #What data comes back from OmniAuth?
    @auth = request.env["omniauth.auth"]
    #Use the token from the data to request a list of calendars
    @token = @auth["credentials"]["token"]
    client = Google::APIClient.new
    client.authorization.access_token = @token
    service = client.discovered_api('calendar', 'v3')

    event = {
      'summary' => 'Google Calendar Test API Event',
      'location' => "Michael's Desk",
      'description' => 'Google Calendar Test API Event',
      'start' => {
        'dateTime' => "#{Chronic.parse('today at 3pm').strftime('%FT%T.%L%:z')}"
      },
      'end' => {
        'dateTime' => "#{Chronic.parse('today at 5pm').strftime('%FT%T.%L%:z')}"
      }
    }
    @result = client.execute(
      :api_method => service.events.insert,
      :parameters => {'calendarId' => 'primary', 'text' => 'Test Event'},
      :body => JSON.dump(event),
      :headers => {'Content-Type' => 'application/json'})
  end

  def new_event_from_params
    @event = Event.new(events_params)
  end

  def events_params
    params[:event].permit(:title, :starts_at, :ends_at) if params[:event]
  end
end