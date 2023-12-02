require "rails_helper" 

RSpec.describe "Movies Index Page" do 
  before(:each) do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
    @nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
    @scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true})
    @tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false})

    @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)
    @dark_knight = Movie.create!(title: "Dark Knight, The", released: 2008, rating: 2, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @goodfellas = Movie.create!(title: "Goodfellas", released: 1990, rating: 3, sex: true, nudity: true, violence: true, director_id: @scorcese.id)
    @pulp_fiction = Movie.create!(title: "Pulp Fiction", released: 1994, rating: 3, sex: false, nudity: false, violence: true, director_id: @tarantino.id)
  end

  it "displays a list of all the movies - and its atrributes - in the system" do 
    visit "/movies" 

    expect(page).to have_content("Movie List")

    expect(page).to have_content("Dr. Strangelove")
    expect(page).to have_content("Released: 1964")
    expect(page).to have_content("Rating: PG")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: false")
    expect(page).to have_content("Violence: false")

    expect(page).to have_content("Jaws")
    expect(page).to have_content("Released: 1975")
    expect(page).to have_content("Rating: PG")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: false")
    expect(page).to have_content("Violence: true")

    expect(page).to have_content("Dark Knight, The")
    expect(page).to have_content("Released: 2008")
    expect(page).to have_content("Rating: PG-13")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: false")
    expect(page).to have_content("Violence: true")

    expect(page).to have_content("Goodfellas")
    expect(page).to have_content("Released: 1990")
    expect(page).to have_content("Rating: R")
    expect(page).to have_content("Sex: true")
    expect(page).to have_content("Nudity: true")
    expect(page).to have_content("Violence: true")

    expect(page).to have_content("Pulp Fiction")
    expect(page).to have_content("Released: 1994")
    expect(page).to have_content("Rating: R")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: false")
    expect(page).to have_content("Violence: true")
  end

  it "has a link to the directors index page" do 
    visit "/movies"

    expect(page).to have_link("directors")

    click_link "directors" 

    expect(current_path).to eq("/directors")
  end

end 