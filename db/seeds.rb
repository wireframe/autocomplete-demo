# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'iconv'
Movie.delete_all
File.open(Rails.root.join('db', 'movies.list')).each_with_index do |l, index|
  next if index < 15
  puts "Imported #{index}..." if index % 1000 == 0
  ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
  valid_string = ic.iconv(l + ' ')[0..-2]
  title = valid_string.split("  ").first
  next if title.include?("{")
  m = Movie.new
  m.title = title
  m.save!
end
