Rails.application.routes.draw do
  get 'users/:user_id/likes' => 'likes#index'
  post 'likes/create' => 'likes#create'
  post 'likes/destroy' => 'likes#destroy'

  get 'signup' => 'users#new'
  get 'login' => 'users#login_form'
  get 'edit_profile' => 'users#edit_profile'
  get 'edit_password' => 'users#edit_password'
  get 'users/:id' => 'users#show'
  post 'users/create' => 'users#create'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  post 'update_profile' => 'users#update_profile'
  post 'update_password' => 'users#update_password'

  get '/' => 'home#top'
  get '/about' => 'home#about'

  get 'notes/index' => 'notes#index'
  get 'notes/new' => 'notes#new'
  get 'notes/:id/edit' => 'notes#edit'
  get 'notes/:id' => 'notes#show'
  post 'notes/create' => 'notes#create'
  post 'notes/:id/update' => 'notes#update'
  post 'notes/:id/destroy' => 'notes#destroy'
end
