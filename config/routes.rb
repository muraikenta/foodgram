Rails.application.routes.draw do
  get 'users/:user_id/likes' => 'likes#index'
  post '/foods/:food_id/create_like' => 'likes#create'
  post '/foods/:food_id/destroy_like' => 'likes#destroy'

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

  get 'foods/index' => 'foods#index'
  get 'foods/new' => 'foods#new'
  get 'foods/:id/edit' => 'foods#edit'
  get 'foods/:id' => 'foods#show'
  post 'foods/create' => 'foods#create'
  post 'foods/:id/update' => 'foods#update'
  post 'foods/:id/destroy' => 'foods#destroy'
end
