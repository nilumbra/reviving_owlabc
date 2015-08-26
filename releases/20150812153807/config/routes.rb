Rails.application.routes.draw do
  devise_for :admins, :path => "admins", :path_names => { :sign_in => 'login', :sign_out => 'logout'}, :controllers => { :sessions => "admins/sessions" }
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout'}, :controllers => { :registrations => "registrations" }
  root :to => "pages#index"
  get 'how_it_works' => "pages#how_it_works"
  get 'our_team' => "pages#our_team"
  get 'faq' => "pages#faq"

  namespace :admin do
    root :to => "pages#index"
    resources :admins do
      get 'edit_password', on: :collection
      put 'update_password', on: :collection
    end
    resources :roles
    resources :permissions
    resources :users do
      get 'switch_payment_status', on: :member
      get 'homework_report', on: :member
      resources :profiles
      post 'batch_operation', on: :collection
    end
    resources :courses do
      get 'clone', on: :member
      get 'publish', on: :member
      resources :units
    end

    resources :units do
      resources :questions
    end

    resources :questions do
      get 'new_choices', on: :member
      resources :choices
    end
    resources :homeworks
  end

  namespace :student do
    root :to => "pages#index"
    get 'unpaid' => "pages#unpaid"
    get 'hold_on' => "pages#hold_on"
    get 'level' => "pages#level"
    get 'events' => "pages#events"
    get 'homework_events' => "pages#homework_events"
    resource :profile do
      put 'upload_avatar'
    end
    resources :feedbacks
    resources :homeworks do
      get 'answer_question', on: :collection
      post 'submit'
    end
  end
end
