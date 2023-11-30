require "rails_helper" 

RSpec.describe "Directors Index Page" do 
  before(:each) do 
    kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
    nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false})
    spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
    scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true})
    tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false})
  end

  it "displays the name of each director in the system" do 
    visit "/directors" 

    expect(page).to have_content("Director List")
    expect(page).to have_content("Kubrick, Stanley")
    expect(page).to have_content("Nolan, Christopher")
    expect(page).to have_content("Spielberg, Steven")
    expect(page).to have_content("Scorcese, Martin")
    expect(page).to have_content("Tarantino, Quentin")
  end
end 