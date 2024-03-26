Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount ActionCable.server => '/cable'
  
  post 'auth/signup', to: 'users#new'
  post 'auth/login', to: 'session#login'

  namespace :api do
    resources :blogs
    resources :users, only: [:create, :show]

    get '/getdashboarddata', to: 'dashboard#get_info'
    get '/add_job', to:'dashboard#modify_schedule_file'
    post '/remove_job', to:'dashboard#remove_custom_section'
    resources :devices
    resources :alarms
    resources :schedulers
    get '/cron_jobs', to: 'cron_jobs#all'
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
