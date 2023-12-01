require "rails_helper" 

RSpec.describe Movie do 
  describe "relationships" do 
    it { should belong_to :director }
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