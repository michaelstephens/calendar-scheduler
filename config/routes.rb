RailsGoogleCalendar::Application.routes.draw do
  resources :events

  get '/logout' => -> env { [200, { 'Content-Type' => 'text/html' }, ['Rack::CAS should have caught this']] }, as: :logout
  root to: 'events#index'
end
