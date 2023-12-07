require "rails_helper" 
require 'date'

RSpec.describe "Directors Index Page" do 
  before(:each) do 
    @kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false, created_at: Date.today - 3})
    @nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false, created_at: Date.today - 1})
    @spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true, created_at: Date.today})
    @scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true, created_at: Date.today - 4})
    @tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false, created_at: Date.today - 2})

    @strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
    @eyes_wide_shut = Movie.create!(title: "Eyes Wide Shut", released: 1999, rating: 3, sex: true, nudity: true, violence: false, director_id: @kubrick.id)
    @full_metal_jacket = Movie.create!(title: "Full Metal Jacket", released: 1987, rating: 3, sex: true, nudity: true, violence: true, director_id: @kubrick.id)
    @space_odyssey = Movie.create!(title: "2001: A Space Odyssey", released: 1968, rating: 0, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
    @close_encounters = Movie.create!(title: "Close Encounters of the Third Kind", released: 1977, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)
    @et = Movie.create!(title: "ET: The Extra Terrestrial", released: 1982, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
    @schindlers_list = Movie.create!(title: "Schindler's List", released: 1993, rating: 3, sex: false, nudity: true, violence: true, director_id: @spielberg.id)
    @dark_knight = Movie.create!(title: "Dark Knight, The", released: 2008, rating: 2, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @memento = Movie.create!(title: "Memento", released: 2001, rating: 3, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @dunkirk = Movie.create!(title: "Dunkirk", released: 2017, rating: 3, sex: false, nudity: false, violence: true, director_id: @nolan.id)
    @goodfellas = Movie.create!(title: "Goodfellas", released: 1990, rating: 3, sex: true, nudity: true, violence: true, director_id: @scorcese.id)
    # @raging_bull = Movie.create!(title: "Raging Bull", released: 1980, rating: 3, sex: false, nudity: true, violence: true, director_id: @scorcese.id)
    @pulp_fiction = Movie.create!(title: "Pulp Fiction", released: 1994, rating: 3, sex: false, nudity: false, violence: true, director_id: @tarantino.id)
    @basterds = Movie.create!(title: "Inglorious Basterds", released: 2009, rating: 3, sex: false, nudity: false, violence: true, director_id: @tarantino.id)
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

  describe "deleting a director" do 
    it "has a 'delete' link next to each director that deletes the director from the system" do 
      visit "/directors" 

      directors = Director.all

      directors.each do |director| 
        within "#index-#{director.id}" do 
          expect(page).to have_link("delete")
        end
      end
      
      expect(page).to have_content("Scorcese, Martin")

      within "#index-#{@scorcese.id}" do 
        click_link "delete"
      end
      
      expect(current_path).to eq("/directors")

      expect(page).to_not have_content("Scorcese, Martin")
    end
  end

  it "has a link to sort directors by movie count descending" do 
    visit "/directors" 

    expect("Spielberg, Steven").to appear_before("Nolan, Christopher")
    expect("Nolan, Christopher").to appear_before("Tarantino, Quentin")
    expect("Tarantino, Quentin").to appear_before("Kubrick, Stanley")
    expect("Kubrick, Stanley").to appear_before("Scorcese, Martin")

    click_link("Sort by Movie Count")

    expect(current_path).to eq("/directors")

    expect("Kubrick, Stanley").to appear_before("Spielberg, Steven")
    expect("Spielberg, Steven").to appear_before("Nolan, Christopher")
    expect("Nolan, Christopher").to appear_before("Tarantino, Quentin")
    expect("Tarantino, Quentin").to appear_before("Scorcese, Martin")
  end

  describe "search form" do 
    it "has a search form where it can find director name matches" do 
      visit "/directors" 

      expect(page).to have_content("Filter by name:")
      expect(page).to have_field(:find_partial)

      expect(page).to have_content("Filter by movie count:")
      expect(page).to have_field(:find_count)

      expect(page).to have_button("Search")

      expect(page).to have_content("Kubrick, Stanley")
      expect(page).to have_content("Spielberg, Steven")
      expect(page).to have_content("Nolan, Christopher")
      expect(page).to have_content("Scorcese, Martin")
      expect(page).to have_content("Tarantino, Quentin")

      fill_in(:find_partial, with: "Stanley Kubrick")

      click_button "Search"

      expect(current_path).to eq("/directors")

      expect(page).to have_content("Kubrick, Stanley")
      expect(page).to have_content("Movie count: 5")
      
      expect(page).to_not have_content("Spielberg, Steven")
      expect(page).to_not have_content("Nolan, Christopher")
      expect(page).to_not have_content("Scorcese, Martin")
      expect(page).to_not have_content("Tarantino, Quentin")
    end

    it "can do a case-insensitive partial name search" do 
      visit "/directors" 

      fill_in(:find_partial, with: "spiel")
      click_button("Search")

      expect(current_path).to eq("/directors")
      
      expect(page).to have_content("Spielberg, Steven")
      expect(page).to have_content("Movie count: 4")

      expect(page).to_not have_content("Nolan, Christopher")
      expect(page).to_not have_content("Movie count: 3")
      expect(page).to_not have_content("Kubrick, Stanley")
      expect(page).to_not have_content("Movie count: 5")
      expect(page).to_not have_content("Scorcese, Martin")
      expect(page).to_not have_content("Movie count: 1")
      expect(page).to_not have_content("Tarantino, Quentin")
      expect(page).to_not have_content("Movie count: 2")
    end

    it "has a search form where it can find director movie count matches" do
      visit "/directors" 

      expect(page).to have_content("Kubrick, Stanley")
      expect(page).to have_content("Movie count: 5")
      expect(page).to have_content("Spielberg, Steven")
      expect(page).to have_content("Movie count: 4")
      expect(page).to have_content("Nolan, Christopher")
      expect(page).to have_content("Movie count: 3")
      expect(page).to have_content("Scorcese, Martin")
      expect(page).to have_content("Movie count: 1")
      expect(page).to have_content("Tarantino, Quentin")
      expect(page).to have_content("Movie count: 2")

      fill_in(:find_count, with: 3)

      click_button "Search"

      expect(current_path).to eq("/directors")

      expect(page).to have_content("Nolan, Christopher")
      expect(page).to have_content("Movie count: 3")
      
      expect(page).to_not have_content("Kubrick, Stanley")
      expect(page).to_not have_content("Movie count: 5")
      expect(page).to_not have_content("Spielberg, Steven")
      expect(page).to_not have_content("Movie count: 4")
      expect(page).to_not have_content("Scorcese, Martin")
      expect(page).to_not have_content("Movie count: 1")
      expect(page).to_not have_content("Tarantino, Quentin")
      expect(page).to_not have_content("Movie count: 2")

      # Test what happens when count doesn't match a director

      fill_in(:find_count, with: 10)
  
      click_button "Search"
  
      expect(current_path).to eq("/directors")
  
      expect(page).to_not have_content("Nolan, Christopher")
      expect(page).to_not have_content("Movie count: 3")
      expect(page).to_not have_content("Kubrick, Stanley")
      expect(page).to_not have_content("Movie count: 5")
      expect(page).to_not have_content("Spielberg, Steven")
      expect(page).to_not have_content("Movie count: 4")
      expect(page).to_not have_content("Scorcese, Martin")
      expect(page).to_not have_content("Movie count: 1")
      expect(page).to_not have_content("Tarantino, Quentin")
      expect(page).to_not have_content("Movie count: 2")
    end
  end

end 