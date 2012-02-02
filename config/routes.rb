Twitter::Application.routes.draw do
  resources :user_sessions
  resources :users
  resources :tweets
  
  get '/logout' => 'user_sessions#destroy', :as => 'logout'
  get 'user/:id/follow' => 'follow_unfollow#follow', :as => 'follow_user'
  get 'user/:id/unfollow' => 'follow_unfollow#unfollow', :as => 'unfollow_user'
  root :to => 'user_sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
