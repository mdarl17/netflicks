# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Movie.destroy_all
Director.destroy_all

@kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
@nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false})
@spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
@scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true})
@tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false})

@strangelove = Movie.create!(title: "Dr. Strangelove", released: 1964, rating: 1, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
@shining = Movie.create!(title: "Shining, The", released: 1980, rating: 2, sex: false, nudity: true, violence: true, director_id: @kubrick.id)
@space_odyssey = Movie.create!(title: "2001: A Space Odyssey", released: 1968, rating: 0, sex: false, nudity: false, violence: false, director_id: @kubrick.id)
@close_encounters = Movie.create!(title: "Close Encounters of the Third Kind", released: 1977, rating: 1, sex: false, nudity: false, violence: false, director_id: @spielberg.id)
@jaws = Movie.create!(title: "Jaws", released: 1975, rating: 1, sex: false, nudity: false, violence: true, director_id: @spielberg.id)
@dark_knight = Movie.create!(title: "Dark Knight, The", released: 2008, rating: 2, sex: false, nudity: false, violence: true, director_id: @nolan.id)
@goodfellas = Movie.create!(title: "Goodfellas", released: 1990, rating: 3, sex: true, nudity: true, violence: true, director_id: @scorcese.id)
@pulp_fiction = Movie.create!(title: "Pulp Fiction", released: 1994, rating: 3, sex: false, nudity: false, violence: true, director_id: @tarantino.id)