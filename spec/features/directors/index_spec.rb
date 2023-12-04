require "rails_helper" 
require 'date'

RSpec.describe "Directors Index Page" do 
  before(:each) do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false, created_at: Date.today - 3})
    @nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false, created_at: Date.today - 1})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true, created_at: Date.today})
    @scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true, created_at: Date.today - 4})
    @tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false, created_at: Date.today - 2})
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

  it "orders directors by most recently created, first." do 
    visit "/directors" 

    expect("Spielberg, Steven").to appear_before("Nolan, Christopher")
    expect("Nolan, Christopher").to appear_before("Tarantino, Quentin")
    expect("Tarantino, Quentin").to appear_before("Kubrick, Stanley")
    expect("Kubrick, Stanley").to appear_before("Scorcese, Martin")
  end

  it "displays the datetime a director was created next to a director's name" do 
    visit "/directors"

    directors = Director.all

    directors.each do |director| 
      within "#index-#{director.id}" do 
        expect(page).to have_content(director.created_at)
      end
    end
  end

  it "has a link to the movies index page" do 
    visit "/directors" 

    expect(page).to have_link("movies")

    click_link "movies" 

    expect(current_path).to eq("/movies")
  end

  describe "creating a new director" do 
    it "has a link to create a new director" do 
      visit "/directors"
  
      expect(page).to have_link("New Director") 
    end

    it "when the new director link is clicked users are redirected to a form to create a new director" do 
      visit "/directors"

      click_link("New Director") 
      expect(current_path).to eq("/directors/new")
      expect(page).to have_content("New Director")
    end 
  end

  describe "updating a director's information" do 
    it "next to every director is a link to edit the director's information" do 
      visit "/directors/"

      directors = Director.all

      directors.each do |director| 
        within "#index-#{director.id}" do 
          expect(page).to have_link("edit")
        end
      end
    end

    it "when the 'edit' link is clicked, users are redirected to the director edit page where they can update a director's info." do 
      visit "/directors"

      within "#index-#{@nolan.id}" do 
        click_link "edit"
        expect(current_path).to eq("/directors/#{@nolan.id}/edit")
      end
      expect(page).to have_content("Update #{@nolan.format_name}'s Bio")

      fill_in(:name, with: "Nolan, Christopher Jonathan James")
      fill_in(:years_active, with: 25)
      fill_in(:best_director, with: true)

      click_button "Update"

      expect(current_path).to eq("/directors/#{@nolan.id}")

      expect(page).to have_content("Christopher Jonathan James Nolan")
      expect(page).to have_content("Years Active: 25")
      expect(page).to have_content("Best Director Oscar: true")
      expect(page).to have_content("The director's bio information has been successfully updated.")
    end
  end
  
end 