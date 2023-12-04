class MoviesController < ApplicationController 
  def index 
    @movies = Movie.all
  end

  def show 
    @movie = Movie.find(params[:id])
  end

  def edit 
    @movie = Movie.find(params[:id])
  end

  def update 
    movie = Movie.find(params[:id])
    director = movie.director

    if movie.update({
      title: params[:title],
      released: params[:released],
      rating: params[:rating].to_i,
      sex: params[:sex],
      nudity: params[:nudity],
      violence: params[:violence],
      director_id: director.id
    })
      flash[:notice] = "The movie has been successfully updated."
      redirect_to "/movies/#{movie.id}"
    else
      flash[:notice] = "Sorry, we were not able to update any movie data. Please try again." 
      redirect_to "/movies/#{movie.id}/edit"
    end
  end
end