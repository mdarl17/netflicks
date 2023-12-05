class DirectorMoviesController < ApplicationController 
  def index 
    @director = Director.find(params[:id])
    
    if params[:sort] 
      @movies = @director.movies.sort_movies(params[:sort])
    else
      @movies = @director.movies
    end

    if params[:released_after]
      @movies = @director.movies.released_after(params[:released_after])
    end
  end

  def new 
    @director = Director.find(params[:id])
  end

  def create 
    director = Director.find(params[:id])

    movie = director.movies.new({
      title: params[:title],
      released: params[:released],
      rating: params[:rating].to_i,
      sex: params[:sex],
      nudity: params[:nudity],
      violence: params[:violence]
    })

    if movie.save
      flash[:notice] = "A new movie has been successfully added."
    else
      flash[:notice] = "Sorry, an error has ocurred. The movie was not added to the system. Please try again."
    end
    redirect_to "/directors/#{director.id}/movies"
  end

end