Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources "sessions", only: :create
      resources "registrations", only: :create

      get "/account/:id/transactions" => "accounts#transaction_history"

      post '/transfer' => 'transfers#transfer_funds'
      post '/credit' => 'credits#add_credit'
    end
  end
end
