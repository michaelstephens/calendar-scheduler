require 'google/api_client'
require 'date'

class Calendar
  attr_accessor :event, :api_event

  def initialize(api_event, event_id)
    @event = Event.find(event_id)
    @api_event = api_event
  end

  def call
    authenticate
    insert?
  end

  private

  def authenticate
    service_account_email = Settings.google_api.service_account_email # Email of service account
    key_file = Settings.google_api.key_file # File containing your private key
    key_secret = Settings.google_api.key_secret # Password to unlock private key

    @client = Google::APIClient.new()

    # Load our credentials for the service account
    key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)
    @client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/analytics.readonly',
      issuer: service_account_email,
      signing_key: key)

    # Request a token for our service account
    @client.authorization.fetch_access_token!

    @service = @client.discovered_api('calendar', 'v3')
  end

  private

  def insert?
    if api_event == "insert"
      insert
    end
  end

  def insert
    @result = @client.execute(
      api_method: @service.events.insert,
      parameters: {'calendarId' => 'primary', 'text' => 'Test Event'},
      body: JSON.dump(event_details(event)),
      headers: {'Content-Type' => 'application/json'})
  end

  def event_details(event)
    # {
    #   'summary' => event.title,
    #   'location' => event.location,
    #   'description' => event.description,
    #   'start' => {
    #     'dateTime' => "#{Chronic.parse(event.starts_at.to_s).strftime('%FT%T.%L%:z')}"
    #   },
    #   'end' => {
    #     'dateTime' => "#{Chronic.parse(event.ends_at.to_s).strftime('%FT%T.%L%:z')}"
    #   },
    #   'visibility' => event.visibility,
    #   "attendees" => attendee_emails_array(email.attendees)
    # }
    {
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
  end

  def attendee_email_array(attendees)
    attendees.each do |attend|
      atts << { "email" => attend }
    end
    return atts
  end
end