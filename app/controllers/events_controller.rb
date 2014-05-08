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
    Calendar.new("insert", Event.first).call
    # params[:event][:attendees] = params[:event][:attendees].split(',')
    # if @event.save
    #   Calendar.new("insert", @event).call
    #   # new_calendar(@event, request)
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

  # def new_calendar(event, request)
  #   #What data comes back from OmniAuth?
  #   @auth = request.env["omniauth.auth"]
  #   #Use the token from the data to request a list of calendars
  #   @token = @auth["credentials"]["token"]
  #   client = Google::APIClient.new
  #   client.authorization.access_token = @token
  #   service = client.discovered_api('calendar', 'v3')
  #
  #   event_details = {
  #     'summary' => event.title,
  #     'location' => event.location,
  #     'description' => event.description,
  #     'start' => {
  #       'dateTime' => "#{Chronic.parse(event.starts_at.to_s).strftime('%FT%T.%L%:z')}"
  #     },
  #     'end' => {
  #       'dateTime' => "#{Chronic.parse(event.ends_at.to_s).strftime('%FT%T.%L%:z')}"
  #     },
  #     'visibility' => event.visibility,
  #     "attendees" => attendee_emails_array(email.attendees)
  #   }
  #
  #   @result = client.execute(
  #     :api_method => service.events.insert,
  #     :parameters => {'calendarId' => 'primary', 'text' => 'Test Event'},
  #     :body => JSON.dump(event_details),
  #     :headers => {'Content-Type' => 'application/json'})
  # end
  #
  # def attendee_email_array(attendees)
  #   attendees.each do |attend|
  #     atts << { "email" => attend }
  #   end
  #   return atts
  # end

  def new_event_from_params
    @event = Event.new(events_params)
  end

  def events_params
    params[:event].permit(:title, :starts_at, :ends_at, :description, :location, :visibility, :attendees, :user_id) if params[:event]
  end
end