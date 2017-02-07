Rails.application.routes.draw do
  get '/' => 'home#top'
  get '/about' => 'home#about'

  get 'notes/index' => 'notes#index'
  get 'notes/new' => 'notes#new'
  get 'notes/:id/edit' => 'notes#edit'
  get 'notes/:id' => 'notes#show'
  post 'notes' => 'notes#create'
  post 'notes/:id/update' => 'notes#update'
  post 'notes/:id/destroy' => 'notes#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
