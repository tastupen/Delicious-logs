Rails.application.routes.draw do
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
