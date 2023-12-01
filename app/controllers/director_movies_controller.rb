class DirectorMoviesController < ApplicationController 
  def index 
    @director = Director.find(params[:id])
    @movies = @director.movies
  end
end