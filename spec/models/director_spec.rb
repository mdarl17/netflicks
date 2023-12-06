require "rails_helper" 

RSpec.describe Director do 
  before(:each) do 
    @kubrick = Director.create!(name: "Kubrick, Stanley", years_active: 47, best_director: false, created_at: Date.today - 3)
    @anderson = Director.create!({name: "Anderson, Paul Thomas", years_active: 25, best_director: false, created_at: Date.today - 5})
    @nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false, created_at: Date.today - 1})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true, created_at: Date.today})
    @scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true, created_at: Date.today - 4})
    @tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false, created_at: Date.today - 2})

    @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @eyes_wide_shut = Movie.create!(title: "Eyes Wide Shut", released: 1999, rating: 3, sex: true, nudity: true, violence: false, director_id: @kubrick.id)
    @full_metal_jacket = Movie.create!(title: "Full Metal Jacket", released: 1987, rating: 3, sex: true, nudity: true, violence: true, director_id: @kubrick.id)
    @space_odyssey = Movie.create!(title: "2001: A Space Odyssey", released: 1968, rating: 0, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @close_encounters = Movie.create!(title: "Close Encounters of the Third Kind", released: 1977, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)
    @et = Movie.create!(title: "ET: The Extra Terrestrial", released: 1982, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @schindlers_list = Movie.create!(title: "Schindler's List", released: 1993, rating: 3, sex: false, nudity: true, violence: true, director_id: @spielberg.id)
    @dark_knight = Movie.create!(title: "Dark Knight, The", released: 2008, rating: 2, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @memento = Movie.create!(title: "Memento", released: 2001, rating: 3, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @dunkirk = Movie.create!(title: "Dunkirk", released: 2017, rating: 3, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @goodfellas = Movie.create!(title: "Goodfellas", released: 1990, rating: 3, sex: true, nudity: true, violence: true, director_id: @scorcese.id)
    # @raging_bull = Movie.create!(title: "Raging Bull", released: 1980, rating: 3, sex: false, nudity: true, violence: true, director_id: @scorcese.id)
    @pulp_fiction = Movie.create!(title: "Pulp Fiction", released: 1994, rating: 3, sex: false, nudity: false, violence: true, director_id: @tarantino.id)
    @basterds = Movie.create!(title: "Inglorious Basterds", released: 2009, rating: 3, sex: false, nudity: false, violence: true, director_id: @tarantino.id)

  end

  describe "relationships" do 
    it { should have_many :movies }
  end

  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :years_active }
    # Why is :best_director presence: true model validation failing when filled with valid data?
    # it { should validate_presence_of :best_director }

    it { should validate_numericality_of :years_active }
    it { should allow_value(true).for :best_director }
    it { should allow_value(false).for :best_director }
    it { should_not allow_value(nil).for :best_director }

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
        expect(@kubrick.movie_count).to eq(5)
        expect(@spielberg.movie_count).to eq(4)
        expect(@nolan.movie_count).to eq(3)
        expect(@tarantino.movie_count).to eq(2)
        expect(@scorcese.movie_count).to eq(1)
        expect(@anderson.movie_count).to eq(0)
      end
    end
  end

  describe "class methods" do 
    describe "#sort_by_created_at" do 
      it "sorts directors by when they were created, with the most recently created ones first" do 
        expect(Director.sort_by_created_at).to eq([@spielberg, @nolan, @tarantino, @kubrick, @scorcese, @anderson])
      end
    end
    
    describe "#sort_by" do 
      it "sorts directors by count" do 
        expect(Director.sort_by("count")).to eq([@kubrick, @spielberg, @nolan, @tarantino, @scorcese])
      end
    end

    describe "#find_count" do 
      it "can search for directors by movie count" do
         expect(Director.find_count(4)).to eq([@spielberg])
         expect(Director.find_count(0)).to eq([])
         expect(Director.find_count(100)).to eq([])
      end
    end

    describe "#find_name" do 
      it "can search directors by case-insensitive partial name" do 
        expect(Director.find_name("spiel")).to eq([@spielberg])
        expect(Director.find_name("Stanley Kubrick")).to eq([@kubrick])
        expect(Director.find_name("Anderson, Paul Thomas")).to eq([@anderson])
        expect(Director.find_name("ander, Pau tho")).to eq([@anderson])
        expect(Director.find_name("anDer, tHo")).to eq([@anderson])
        expect(Director.find_name("s")).to eq([@kubrick, @anderson, @nolan, @spielberg, @scorcese])
        expect(Director.find_name("z")).to eq([])
        expect(Director.find_name("")).to eq([])
      end
    end
  end
end 