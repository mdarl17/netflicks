require "rails_helper"

RSpec.describe "Director Movies Index Page" do 
  before(:each) do 
    @kubrick = Director.create!(name: "Kubrick, Stanley", years_active: 47, best_director: false)
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
    @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 3, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @eyes_wide_shut = Movie.create!(title: "Eyes Wide Shut", released: 1999, rating: 3, sex: true, nudity: true, violence: false, director_id: @kubrick.id)
    @full_metal_jacket = Movie.create!(title: "Full Metal Jacket", released: 1987, rating: 3, sex: true, nudity: true, violence: true, director_id: @kubrick.id)
    @space_odyssey = Movie.create!(title: "2001: A Space Odyssey", released: 1968, rating: 0, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)
  end

  it "displays all of a director's movies, along with the movies' attributes" do 

    visit "/directors/#{@kubrick.id}/movies"

    expect(page).to have_content("Stanley Kubrick Movies")
    
    expect(page).to have_content("Dr. Strangelove")
    expect(page).to have_content("Released: 1964")
    expect(page).to have_content("Rating: PG")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: false")
    expect(page).to have_content("Violence: false")

    expect(page).to have_content("The Shining")
    expect(page).to have_content("Released: 1980")
    expect(page).to have_content("Rating: R")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: true")
    expect(page).to have_content("Violence: true")

    expect(page).to have_content("2001: A Space Odyssey")
    expect(page).to have_content("Released: 1968")
    expect(page).to have_content("Rating: G")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: false")
    expect(page).to have_content("Violence: false") 

    expect(page).to_not have_content("Jaws")
  end

  it "has a link to the movies index page" do 
    visit "/directors/#{@kubrick.id}/movies"
    
    expect(page).to have_link("movies")

    click_link "movies" 

    expect(current_path).to eq("/movies")
  end

  it "has a link to the directors index page" do 
    visit "/directors/#{@kubrick.id}/movies"

    expect(page).to have_link("directors")

    click_link "directors" 

    expect(current_path).to eq("/directors")
  end

  it "has a link to add a new movie" do 
    visit "/directors/#{@spielberg.id}/movies" 

    expect(page).to have_link("Create Movie")

    click_link "Create Movie" 

    expect(current_path).to eq("/directors/#{@spielberg.id}/movies/new")
    expect(page).to have_content("Add a #{@spielberg.format_name} Movie")
  end

  it "sorts a director's movies alphabetically" do 
    visit "/directors/#{@kubrick.id}/movies"

    expect(page).to have_link("Sort Movies")

    expect("Dr. Strangelove").to appear_before("The Shining")
    expect("The Shining").to appear_before("Eyes Wide Shut")
    expect("Eyes Wide Shut").to appear_before("Full Metal Jacket")
    expect("Full Metal Jacket").to appear_before("2001: A Space Odyssey")

    click_link "Sort Movies" 

    expect(current_path).to eq("/directors/#{@kubrick.id}/movies")

    expect("2001: A Space Odyssey").to appear_before("Dr. Strangelove")
    expect("Dr. Strangelove").to appear_before("Eyes Wide Shut")
    expect("Eyes Wide Shut").to appear_before("Full Metal Jacket")
    expect("Full Metal Jacket").to appear_before("The Shining")
  end
  
end