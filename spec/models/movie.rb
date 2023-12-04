require "rails_helper" 

RSpec.describe Movie do 

  before(:each) do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
    @nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
    @scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true})
    @tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false})

    @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @dark_knight = Movie.create!(title: "Dark Knight, The", released: 2008, rating: 2, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @goodfellas = Movie.create!(title: "Goodfellas", released: 1990, rating: 3, sex: true, nudity: true, violence: true, director_id: @scorcese.id)
    @pulp_fiction = Movie.create!(title: "Pulp Fiction", released: 1994, rating: 3, sex: true, nudity: true, violence: true, director_id: @tarantino.id)
   end

  describe "relationships" do 
    it { should belong_to :director }
  end

  describe "class methods" do 
    describe "#adult_content" do 
      it "returns only movies that contain adult content" do 
        expect(Movie.adult_content).to eq([@shining, @goodfellas, @pulp_fiction])
      end
    end

    describe "#violent" do 
      it "returns only movies that contain violence" do 
        expect(Movie.violence).to eq([@shining, @dark_knight, @goodfellas, @pulp_fiction])
      end
    end
  end

  describe "instance methods" do 
    describe "#format_title" do 
      it "the title will begin with 'The' or 'A', (or something similar) if the non-specific was made the last word on the movies index page for sorting purposes" do 
        @nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false})
        @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
        
        @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
        @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
        @dark_knight = Movie.create!(title: "Dark Knight, The", released: 2008, rating: 2, sex: false, nudity: false, violence: true, director_id: @nolan.id)
        
        expect(@strangelove.format_title).to eq("Dr. Strangelove")
        expect(@shining.format_title).to eq("The Shining")
        expect(@dark_knight.format_title).to_not eq("Dark Knight, The")
      end
    end
  end
end 