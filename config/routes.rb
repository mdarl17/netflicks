Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/movies", to: "movies#index"
  get "/movies/:id", to: "movies#show"

  get "/directors", to: "directors#index"
  get "/directors/:id", to: "directors#show"
  get "/directors/:id/movies", to: "director_movies#index"
end
