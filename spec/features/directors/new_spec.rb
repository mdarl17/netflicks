require "rails_helper" 

RSpec.describe "New Director Page" do 
  it "has a form to create a new director" do 
    visit "/directors/new"

    expect(page).to have_content("Name")
    expect(page).to have_field(:name)
    expect(page).to have_content("Years active")
    expect(page).to have_field(:years_active)
    expect(page).to have_content("Best director")
    expect(page).to have_field(:best_director)
    expect(page).to have_button("Create Director")

    fill_in(:name, with: "Allen, Woody")
    fill_in(:years_active, with: 53)
    fill_in(:best_director, with: true)

    click_button "Create Director"

    expect(current_path).to eq("/directors")
    expect(page).to have_content("Allen, Woody")

   #TODO --> CREATE FAILING TESTS
  end
  
end 