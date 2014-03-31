# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# ruby encoding: utf-8

screen1 = Movie::Screen.create!(name: "Multikino sala 1")
screen2 = Movie::Screen.create!(name: "Multikino sala 2")

matrix = Movie.create!(title: 'Matrix', description: 'Super Neo fighting and flying!', cover_url: 'assets/movies_covers/matrix.jpg', duration: 120)

matrix2 = Movie.create!(title: 'Matrix 2', description: 'Super Neo fighting and flying even more!', cover_url: 'assets/movies_covers/matrix2.jpg', duration: 130)

5.times do |i|
  matrix.shows << Movie::Show.new(date: DateTime.now + i.hours, screen: screen1)
  matrix2.shows << Movie::Show.new(date: DateTime.now + (1+i).hours, screen: screen2)
end
