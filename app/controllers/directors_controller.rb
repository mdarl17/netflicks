class DirectorsController < ApplicationController 
  def index 
    @directors = Director.all
  end

  def show 
    @director = Director.find(params[:id])
  end

  def new 

  end

  def create 
    director = Director.create!({name: params[:name], years_active: params[:years_active], best_director: params[:best_director]})

    unless director
      flash[:notice] = "Sorry, something went wrong. Please try again."
      redirect_to "/directors/new"
    end
    
    flash[:notice] = "New director created."
    redirect_to "/directors"
  end
end