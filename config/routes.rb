Rails.application.routes.draw do
  get 'signup' => 'users#new'
  get 'login' => 'users#login_form'
  get 'users/:id' => 'users#show'
  post 'users' => 'users#create'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'

  get '/' => 'home#top'
  get '/about' => 'home#about'

  get 'notes/index' => 'notes#index'
  get 'notes/new' => 'notes#new'
  get 'notes/:id/edit' => 'notes#edit'
  get 'notes/:id' => 'notes#show'
  post 'notes' => 'notes#create'
  post 'notes/:id/update' => 'notes#update'
  post 'notes/:id/destroy' => 'notes#destroy'
end
