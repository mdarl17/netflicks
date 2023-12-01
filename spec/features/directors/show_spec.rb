require "rails_helper" 

RSpec.describe "Director Show Page" do 
  before(:each) do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
    @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @space_odyssey = Movie.create!(title: "2001: A Space Odyssey", released: 1968, rating: 0, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @close_encounters = Movie.create!(title: "Close Encounters of the Third Kind", released: 1977, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)  
   end

  it "given an id, it displays a parent and that parent's attributes" do 

    visit "/directors/#{@kubrick.id}"

    expect(page).to have_content("Director Details")
    expect(page).to have_content("Stanley Kubrick")
    expect(page).to have_content("Years Active: 47")
    expect(page).to have_content("Best Director Oscar: false")
  end

  it "displays the number of movies in the system that a director has made" do 
    
    visit "/directors/#{@kubrick.id}" 

    expect(page).to have_content("Movie Count: 3")
  end

  it "has a link to the movies index page" do 
    visit "/directors/#{@kubrick.id}"
    
    expect(page).to have_link("movies")

    click_link "movies"

    expect(current_path).to eq("/movies")
  end
end 