# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

CourseSection.create([
  { name: 'Aperitivo(食前酒)' },
  { name: 'Antipasto(前菜)' },
  { name: 'Primo piatto'},
  { name: 'Secondo piatto'},
  { name: 'Contorno(付け合わせ)'},
  { name: 'Dolce'},
  { name: 'Caffé Digestivo(コーヒー 食後酒)'}
])
