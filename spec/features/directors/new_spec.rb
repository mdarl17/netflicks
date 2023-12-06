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
  end

  it "validates all fields have a value with the correct datatype" do 
    visit "/directors/new" 

    fill_in(:name, with: " ")
    fill_in(:years_active, with: 53)
    fill_in(:best_director, with: true)

    click_button "Create Director"

    expect(current_path).to eq("/directors/new")
    expect(Director.where("name = ?", "")).to eq([])

    fill_in(:name, with: "Allen, Woody")
    fill_in(:years_active, with: " " )
    fill_in(:best_director, with: true)

    click_button "Create Director"

    expect(current_path).to eq("/directors/new")
    expect(Director.where("name = ?", "Allen, Woody")).to eq([])

    
    # TODO: ASK HOW TO INVALIDATE EMPTY STRING FOR ATTRIBUTE W/ BOOLEAN DATATYPE
    
    # fill_in(:name, with: "Allen, Woody")
    # fill_in(:years_active, with: 53 )
    # fill_in(:best_director, with: " ")
    
    # click_button "Create Director"
    
    # expect(current_path).to eq("/directors/new")
    # expect(Director.where("name = ?", "Allen, Woody")).to eq([])

    fill_in(:name, with: 22)
    fill_in(:years_active, with: 53)
    fill_in(:best_director, with: true)

    click_button "Create Director"

    expect(current_path).to eq("/directors/new")
    expect(Director.where("name = ?", "22")).to eq([])

    fill_in(:name, with: "Allen, Woody")
    fill_in(:years_active, with: "Fifty-Three")
    fill_in(:best_director, with: true)

    click_button "Create Director"

    expect(current_path).to eq("/directors/new")
    expect(Director.where("name = ?", "Allen, Woody")).to eq([])
  end

end 