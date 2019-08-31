Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'sessions/new' => 'sessions#create'
      post 'registrations/new' => 'registrations#create'
    end
  end

end
