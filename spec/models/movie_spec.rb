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
    @eyes_wide_shut = Movie.create!(title: "Eyes Wide Shut", released: 1999, rating: 3, sex: true, nudity: true, violence: false, director_id: @kubrick.id)
    @full_metal_jacket = Movie.create!(title: "Full Metal Jacket", released: 1987, rating: 3, sex: true, nudity: true, violence: true, director_id: @kubrick.id)
    @space_odyssey = Movie.create!(title: "2001: A Space Odyssey", released: 1968, rating: 0, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @dark_knight = Movie.create!(title: "Dark Knight, The", released: 2008, rating: 2, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @goodfellas = Movie.create!(title: "Goodfellas", released: 1990, rating: 3, sex: true, nudity: true, violence: true, director_id: @scorcese.id)
    @pulp_fiction = Movie.create!(title: "Pulp Fiction", released: 1994, rating: 3, sex: true, nudity: true, violence: true, director_id: @tarantino.id)
   end

  describe "validations" do 
    it { should validate_presence_of :title }
    it { should validate_presence_of :released }
    it { should validate_presence_of :rating }

    # TODO why are valid boolean values returning 'false' even though they are present? (e.g. setup data failing)

    # it { should validate_presence_of :sex }
    # it { should validate_presence_of :nudity }
    # it { should validate_presence_of :violence }

    it { should validate_numericality_of :released }

    it {should allow_value(/[a-zA-Z]/).for :title }
    it {should allow_value('G').for :rating}
    it {should allow_value('PG').for :rating}
    it {should allow_value('PG-13').for :rating}
    it {should allow_value('R').for :rating}
    it {should allow_value(true).for :sex }
    it {should allow_value(false).for :sex }
    it {should_not allow_value(nil).for :sex }

    it {should allow_value(true).for :nudity }
    it {should allow_value(false).for :nudity }
    it {should_not allow_value(nil).for :nudity }

    it {should allow_value(true).for :violence }
    it {should allow_value(false).for :violence }
    it {should_not allow_value(nil).for :violence }

    it { should validate_length_of(:released), minimum: 0, maximum: Time.now.year }
  end

  describe "relationships" do 
    it { should belong_to :director }
  end

  describe "class methods" do 
    describe "#mature_content" do 
      it "returns movies that contain violence OR adult content" do 
        expect(Movie.mature_content).to eq([@shining, @eyes_wide_shut, @full_metal_jacket, @dark_knight, @goodfellas, @pulp_fiction])
      end
    end
    
    # describe "#adult_content" do 
    #   it "returns only movies that contain adult content" do 
    #     expect(Movie.adult_content).to eq([@shining, @eyes_wide_shut, @full_metal_jacket, @goodfellas, @pulp_fiction])
    #   end
    # end

    # describe "#violent" do 
    #   it "returns only movies that contain violence" do 
    #     expect(Movie.violence).to eq([@shining,@full_metal_jacket, @dark_knight, @goodfellas, @pulp_fiction])
    #   end
    # end

    describe "#sort_movies" do 
      it "sorts movies in a manner contingent on argument" do 
        expect(@kubrick.movies.sort_movies("alpha")).to eq([@space_odyssey, @strangelove, @eyes_wide_shut, @full_metal_jacket, @shining])
      end
    end

    describe "#released_after" do 
      it "only displays movies after a user-provided year" do 
        expect(@kubrick.movies.released_after(1980)).to eq([@eyes_wide_shut, @full_metal_jacket])
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