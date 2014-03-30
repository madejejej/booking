# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Movie.new(title: 'Matrix', description: 'Super Neo fighting and flying!', cover_url: 'assets/movies_covers/matrix.jpg', duration: 120).save()
Movie.new(title: 'Matrix 2', description: 'Super Neo fighting and flying even more!', cover_url: 'assets/movies_covers/matrix2.jpg', duration: 130).save()