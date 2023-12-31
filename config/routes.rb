Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/movies/:id/edit", to: "movies#edit"
  patch "/movies/:id", to: "movies#update"
  get "/movies", to: "movies#index"
  get "/movies/:id", to: "movies#show"
  delete "/movies/:id", to: "movies#destroy"

  get "/directors", to: "directors#index"
  get "/directors/:id/edit", to: "directors#edit"
  patch "/directors/:id", to: "directors#update"
  post "/directors", to: "directors#create"
  get "/directors/new", to: "directors#new"
  get "/directors/:id", to: "directors#show"
  delete "/directors/:id", to: "directors#destroy"

  get "/directors/:id/movies", to: "director_movies#index"
  get "/directors/:id/movies/new", to: "director_movies#new"
  post "/directors/:id/movies", to: "director_movies#create"

end
