require "rails_helper" 

RSpec.describe "Movie Show Page" do 
  it "given the movie's id, it displays that movie and all of the movie's attributes" do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 3, sex: false, nudity: true, violence: true, director_id: @kubrick.id)

    visit "/movies/#{@shining.id}"

    expect(page).to have_content("Movie Details")
    expect(page).to have_content("The Shining")
    expect(page).to have_content("Released: 1980")
    expect(page).to have_content("Rating: R")
    expect(page).to have_content("Sex: false")
    expect(page).to have_content("Nudity: true")
    expect(page).to have_content("Violence: true")
  end

end 