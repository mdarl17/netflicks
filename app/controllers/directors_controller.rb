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
    director = Director.new({name: params[:name], years_active: params[:years_active], best_director: params[:best_director]})
    
    if director.save
      flash[:notice] = "New director created."
      redirect_to "/directors"
    else
      flash[:notice] = "Sorry, something went wrong. Please try again."
      redirect_to "/directors/new"
    end
  end

end