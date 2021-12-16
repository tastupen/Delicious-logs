Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => "users/sessions",
    :passwords => 'users/passwords',
    :unlocks => 'users/unlocks',
  }
  
  devise_scope :user do
    root :to => "users/sessions#new"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end
  
  resource :users, only: [:edit, :update] do
    collection do
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      put "mypage", :to => "users#update"
      delete "mypage/delete", :to => "users#destroy"
      get "mypage/edit_password", :to =>"users#edit_password"
      put "mypage/password", :to => "users#update_password"
    end
  end
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
