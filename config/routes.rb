Rails.application.routes.draw do
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }
  
  devise_scope :admin do
    get "dashboard", :to => "dashboard#index"
    get "dashboard/login", :to => "admins/sessions#new"
    post "dashboard/login", :to => "admins/sessions#create"
    delete "dashboard/logout", :to => "admins/sessions#destroy"
  end
  
  namespace :dashboard do
    resources :genres, except: [:new]
    resources :products, except: [:show] do
      collection do
        get  "import/csv", :to => "products#import"
        post "import/csv", :to => "products#import_csv"
        get  "import/csv_download", :to => "products#download_csv"
      end
    end
  end
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => "users/sessions",
    :passwords => 'users/passwords',
    :unlocks => 'users/unlocks',
  }
  
  devise_scope :user do
    root :to => "web#index"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end
  
  resource :users, only: [:edit, :update] do
    collection do
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      put "mypage", :to => "users#update"
      get "mypage/myposts", :to => "users#myposts"
      get "mypage/edit_password", :to =>"users#edit_password"
      put "mypage/password", :to => "users#update_password"
      delete "mypage/delete", :to => "users#destroy"
    end
  end
  
  #likes
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  
  #search
  get 'search' => "searchs#search"
  
  #genre
  get 'genres' => "genres#index"
  
  resources :products do
    resources :reviews, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
