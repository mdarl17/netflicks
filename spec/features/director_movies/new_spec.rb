require "rails_helper" 

RSpec.describe "New Director Movie Page" do 
  before(:each) do 
    @tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false})
  end

  it "has a form to add a director's movie" do 

    visit "/directors/#{@tarantino.id}/movies/new"
    
    expect(page).to have_content("Title")
    expect(page).to have_field(:title)
    expect(page).to have_content("Released")
    expect(page).to have_field(:released)
    expect(page).to have_content("Rating")
    expect(page).to have_field(:rating)
    expect(page).to have_content("Sex")
    expect(page).to have_field(:sex)
    expect(page).to have_content("Nudity")
    expect(page).to have_field(:nudity)
    expect(page).to have_content("Violence")
    expect(page).to have_field(:violence)
    expect(page).to have_button("Create Movie")

    fill_in(:title, with: "Inglorious Basterds")
    fill_in(:released, with: 1994)
    fill_in(:rating, with: 3)
    fill_in(:sex, with: false)
    fill_in(:nudity, with: false)
    fill_in(:violence, with: true)

    click_button("Create Movie")

    expect(current_path).to eq("/directors/#{@tarantino.id}/movies")
    
    new_movie = Movie.find_by("title = 'Inglorious Basterds'")

    expect(page).to have_content(new_movie.title)
    expect(page).to have_content(new_movie.released)
    expect(page).to have_content(new_movie.rating)
    expect(page).to have_content(new_movie.sex)
    expect(page).to have_content(new_movie.nudity)
    expect(page).to have_content(new_movie.violence)
  end

  it "validates all of the form's fields have data that is of the correct datatype" do 
    visit "/directors/#{@tarantino.id}/movies/new"

    fill_in(:title, with: " ")
    fill_in(:released, with: " ")
    fill_in(:rating, with: " ")
    fill_in(:sex, with: " ")
    fill_in(:nudity, with: " ")
    fill_in(:violence, with: " ")

    click_button "Create Movie"

    expect(current_path).to eq("/directors/#{@tarantino.id}/movies")
    expect(page).to have_content("Sorry, an error has ocurred. The movie was not added to the system. Please try again.")
    
    visit "/directors/#{@tarantino.id}/movies/new"
    
    fill_in(:title, with: "Inglorious Basterds")
    fill_in(:released, with: "Two-thousand nine")
    fill_in(:rating, with: 3)
    fill_in(:sex, with: false)
    fill_in(:nudity, with: false)
    fill_in(:violence, with: true)
    
    click_button "Create Movie"
    
    expect(current_path).to eq("/directors/#{@tarantino.id}/movies")
    expect(page).to have_content("Sorry, an error has ocurred. The movie was not added to the system. Please try again.")

    # visit "/directors/#{@tarantino.id}/movies/new"
      
    # fill_in(:title, with: "Inglorious Basterds")
    # fill_in(:released, with: 2009)
    # fill_in(:rating, with: "Rated R")
    # fill_in(:sex, with: false)
    # fill_in(:nudity, with: false)
    # fill_in(:violence, with: true)
    
    # click_button "Create Movie"
    
    # expect(current_path).to eq("/directors/#{@tarantino.id}/movies")
    # expect(page).to have_content("Sorry, an error has ocurred. The movie was not added to the system. Please try again.")
  end

end 