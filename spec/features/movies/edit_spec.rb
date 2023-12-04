require "rails_helper" 

RSpec.describe "Edit Movie Page" do 
  before(:each) do 
    @spielberg = Director.create!(name: "Spielberg, Steven", years_active: 56, best_director: true)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)
   end

  it "has a form to edit a movie's attributes" do 

    visit "/movies/#{@jaws.id}/edit"

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
    expect(page).to have_button("Update Movie") 

    fill_in(:title, with: "Jaws")
    fill_in(:released, with: 1976)
    fill_in(:rating, with: 2)
    fill_in(:sex, with: true)
    fill_in(:nudity, with: false)
    fill_in(:violence, with: true)

    click_button "Update Movie" 

    expect(current_path).to eq("/movies/#{@jaws.id}")

    expect(page).to have_content("Jaws")
    expect(page).to have_content("Released: 1976")
    expect(page).to have_content("Rating: PG-13")
    expect(page).to have_content("Sex: true")
    expect(page).to have_content("Nudity: false")
    expect(page).to have_content("Violence: true")
  end

  it "won't update a movie if it doesn't have a title" do 
    visit "/movies/#{@jaws.id}/edit"

    fill_in(:title, with: " ")
    fill_in(:released, with: 1975 )
    fill_in(:rating, with: 2)
    fill_in(:sex, with: false)
    fill_in(:nudity, with: false)
    fill_in(:violence, with: true)

    click_button("Update Movie")

    expect(page).to have_content("Sorry, we were not able to update any movie data. Please try again.")
  end

  it "won't update a movie if the title isn't a string" do 
    visit "/movies/#{@jaws.id}/edit"

    fill_in(:title, with: 37)
    fill_in(:released, with: 1975 )
    fill_in(:rating, with: 2)
    fill_in(:sex, with: false)
    fill_in(:nudity, with: false)
    fill_in(:violence, with: true)

    click_button("Update Movie")

    expect(page).to have_content("Sorry, we were not able to update any movie data. Please try again.")
  end

  it "won't update a movie if it doesn't have a release date" do 
    visit "/movies/#{@jaws.id}/edit"

    fill_in(:title, with: "Jaws")
    fill_in(:released, with: " " )
    fill_in(:rating, with: 2)
    fill_in(:sex, with: false)
    fill_in(:nudity, with: false)
    fill_in(:violence, with: true)

    click_button("Update Movie")

    expect(page).to have_content("Sorry, we were not able to update any movie data. Please try again.")
  end

  it "won't update a movie if the release date isn't an integer" do 
    visit "/movies/#{@jaws.id}/edit"

    fill_in(:title, with: "Jaws")
    fill_in(:released, with: "Nineteen Seventy-Five" )
    fill_in(:rating, with: 2)
    fill_in(:sex, with: false)
    fill_in(:nudity, with: false)
    fill_in(:violence, with: true)

    click_button("Update Movie")

    expect(page).to have_content("Sorry, we were not able to update any movie data. Please try again.")
  end
  
  # TODO Must figure out why rating and boolean attributes are creating default values if empty or wrong datatype
  # it "won't update a movie if it doesn't have a rating." do 
  #   visit "/movies/#{@jaws.id}/edit"

  #   fill_in(:title, with: "Jaws")
  #   fill_in(:released, with: 1975 )
  #   fill_in(:rating, with: " ")
  #   fill_in(:sex, with: false)
  #   fill_in(:nudity, with: false)
  #   fill_in(:violence, with: true)

  #   click_button("Update Movie")

  #   expect(page).to have_content("Sorry, we were not able to update any movie data. Please try again.")
  # end

end 