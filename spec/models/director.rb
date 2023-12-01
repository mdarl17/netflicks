require "rails_helper" 

RSpec.describe Director do 
  before(:each) do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
    @anderson = Director.create!({name: "Anderson, Paul Thomas", years_active: 25, best_director: false})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
    @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @space_odyssey = Movie.create!(title: "2001: A Space Odyssey", released: 1968, rating: 0, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @boogie = Movie.create!(title: "Boogie Nights", released: 1997, rating: 3, sex: true, nudity: true, violence: true, director_id: @anderson.id)
    @close_encounters = Movie.create!(title: "Close Encounters of the Third Kind", released: 1977, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)  

  end

  describe "relationships" do 
    it { should have_many :movies }
  end

  describe "instance methods" do 
    describe "#format_name" do 
      it "displays a director's name with first name followed by middle, if any, then last name" do 
        expect(@kubrick.format_name).to eq("Stanley Kubrick")
        expect(@anderson.format_name).to eq("Paul Thomas Anderson")
      end
    end
    
    describe "#movie_count" do 
      it "returns the number of movies in the system a director has made" do 
        expect(@kubrick.movie_count).to eq(3)
        expect(@anderson.movie_count).to eq(1)
        expect(@spielberg.movie_count).to eq(2)
      end
    end
  end
end 