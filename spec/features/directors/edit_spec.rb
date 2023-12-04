require "rails_helper"

RSpec.describe "Director Edit Page" do 
  it "displays a form for users to modify a director's name, years_active, and best_director attributes" do 
    @scorcese = Director.create!({name: "Scorcese, Marty", years_active: 51, best_director: false})

    visit "/directors/#{@scorcese.id}/edit"
    
    expect(page).to have_content("Update #{@scorcese.format_name}'s Bio")

    expect(page).to have_content("Name")
    expect(page).to have_field(:name, with: "Scorcese, Marty")
    expect(page).to have_content("Years active")
    expect(page).to have_field(:years_active, with: 51)
    expect(page).to have_content("Best director")
    expect(page).to have_field(:best_director, with: false)
    expect(page).to have_button("Update")
    
    fill_in(:name, with: "Scorcese, Martin")
    fill_in(:years_active, with: 60)
    fill_in(:best_director, with: true)

    click_button "Update" 

    expect(current_path).to eq("/directors/#{@scorcese.id}") 
    expect(page).to have_content("Director Details")
    expect(page).to have_content("Martin Scorcese")
    expect(page).to have_content("Years Active: 60")
    expect(page).to have_content("Best Director Oscar: true")
    expect(page).to have_content("The director's bio information has been successfully updated.")
  end

  it "validates that each text field has a value with the correct datatype" do 
    @scorcese = Director.create!({name: "Scorcese, Marty", years_active: 51, best_director: false})

    visit "/directors/#{@scorcese.id}/edit" 

    fill_in(:name, with: " ")
    fill_in(:years_active, with: 53)
    fill_in(:best_director, with: true)

    click_button "Update"

    expect(current_path).to eq("/directors/#{@scorcese.id}/edit")
    expect(Director.where("name = ?", "")).to eq([])
    expect(page).to have_content("Sorry, there was an error and the director's bio information was not updated. Please try updating again.")

    fill_in(:name, with: @scorcese.name)
    fill_in(:years_active, with: "")
    fill_in(:best_director, with: true)

    click_button "Update"

    expect(current_path).to eq("/directors/#{@scorcese.id}/edit")
    expect(page).to have_content("Sorry, there was an error and the director's bio information was not updated. Please try updating again.")

    fill_in(:name, with: 332342)
    fill_in(:years_active, with: 51)
    fill_in(:best_director, with: true)

    click_button "Update"

    expect(current_path).to eq("/directors/#{@scorcese.id}/edit")
    expect(page).to have_content("Sorry, there was an error and the director's bio information was not updated. Please try updating again.")

    fill_in(:name, with: "Scorcese, Martin")
    fill_in(:years_active, with: "Fifty-one")
    fill_in(:best_director, with: true)

    click_button "Update"

    expect(current_path).to eq("/directors/#{@scorcese.id}/edit")
    expect(page).to have_content("Sorry, there was an error and the director's bio information was not updated. Please try updating again.")
  end

end 