Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Settings.google_api.client_id, Settings.google_api.client_secret, {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
    redirect_uri: Settings.google_api.redirect_uri
  }
end