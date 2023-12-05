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

  def edit 
    @director = Director.find(params[:id])
  end

  def update 
    director = Director.find(params[:id])

    # Not using update! (with bang!) b/c validations stop program execution
    if director.update({name: params[:name], years_active: params[:years_active], best_director: params[:best_director]})
      flash[:notice] = "The director's bio information has been successfully updated."
      redirect_to "/directors/#{params[:id]}"
    else
      flash[:notice] = "Sorry, there was an error and the director's bio information was not updated. Please try updating again." 
      redirect_to "/directors/#{director.id}/edit"
    end
  end

  def destroy 
    Director.destroy(params[:id])

    redirect_to "/directors"
  end

end