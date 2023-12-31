require "rails_helper" 

RSpec.describe "Movie Show Page" do 
  before(:each) do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 3, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @close_encounters = Movie.create!(title: "Close Encounters of the Third Kind", released: 1977, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
   end

  it "given the movie's id, it displays that movie and all of the movie's attributes" do 
    visit "/movies/#{@shining.id}"

    expect(page).to have_content("Movie Details")
    expect(page).to have_content("The Shining")
    expect(page).to have_content("Released: 1980")
    expect(page).to have_content("Rating: R")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: true")
    expect(page).to have_content("Violence: true")
  end

  it "has a link to the movies index page" do 
    visit "/movies/#{@shining.id}"

    expect(page).to have_link("movies")

    click_link "movies"

    expect(current_path).to eq("/movies")
  end

  it "has a link to the directors index page" do 
    visit "/movies/#{@shining.id}"

    expect(page).to have_link("directors")

    click_link "directors" 

    expect(current_path).to eq("/directors")
  end

  it "has a link to update a movie" do 
    visit "/movies/#{@close_encounters.id}"

    expect(page).to have_link("Update Movie")

    click_link("Update Movie")

    expect(current_path).to eq("/movies/#{@close_encounters.id}/edit") 

    expect(page).to have_content("Edit #{@close_encounters.title}")
  end

  it "each movie has a 'delete' link next to it that allows users to delete that movie from the system" do 
    movies = Movie.all

    movies.each do |movie| 
      visit "/movies/#{movie.id}"
      expect(page).to have_link("Delete Movie")
    end

    visit "/movies" 

    expect(page).to have_content("Shining, The")

    visit "/movies/#{@shining.id}"

    click_link "Delete Movie" 

    expect(current_path).to eq("/movies")

    expect(page).to_not have_content("Shining, The")
  end

end 