class MoviesController < ApplicationController 
  def index 
    if params[:find_exact] && params[:find_exact].length > 0 
      @movies = Movie.exact_search(params[:find_exact])
    elsif params[:find_partial] && params[:find_partial].length > 0
      @movies = Movie.partial_search(params[:find_partial])
    else
      @movies = Movie.all
    end
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
  
  def destroy 
    Movie.destroy(params[:id])

    redirect_to "/movies"
  end
end