Rails.application.routes.draw do
  resources :posts do
    member do
      get :list_of_posts
      get :like
      get :dislike
      get :new_comment
      post :create_new_comment
      get :show_all_comments
      get :delete_comment
    end
  end
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  root 'users#home'
  resources :users do
    member do
      get :show
      get :send_friend_request
      get :cancel_friend_request
      get :all_friend_requests
      get :confirm
      get :reject
    end
  end


end
