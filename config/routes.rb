Rails.application.routes.draw do
  get '/' => 'home#top'
  get '/about' => 'home#about'

  get 'notes/index' => 'notes#index'
  get 'notes/:id' => 'notes#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
