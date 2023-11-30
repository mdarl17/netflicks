require "rails_helper" 

RSpec.describe "Director Show Page" do 
  it "given an id, it displays a parent and that parent's attributes" do 
    kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})

    visit "/directors/#{kubrick.id}"

    expect(page).to have_content("Director Details")
    expect(page).to have_content("Stanley Kubrick")
    expect(page).to have_content("Years Active: 47")
    expect(page).to have_content("Best Director Oscar: false")
  end
end 