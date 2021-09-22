Rails.application.routes.draw do
  get "login" => "session#new"
  post "login"    => "session#create"
  delete "logout"   => "session#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'application#hello', :as => 'home'
  resources :users do
    resources :urls
  end
  get "/:short_url", to: "urls#shortened"

  get '/api/urls' => 'api#urls', :as => "urls_of_user"
  post '/api/url' => 'api#new_url', :as => "new_url"
end
