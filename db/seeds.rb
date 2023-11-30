# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Director.destroy_all

kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
nolan = Director.create!({name: "Nolan, Christopher", years_active: 19, best_director: false})
spielberg = Director.create!({name: "Spielberg, Steven", years_active: 56, best_director: true})
scorcese = Director.create!({name: "Scorcese, Martin", years_active: 51, best_director: true})
tarantino = Director.create!({name: "Tarantino, Quentin", years_active: 25, best_director: false})