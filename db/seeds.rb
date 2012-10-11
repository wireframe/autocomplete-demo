# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'iconv'
Movie.delete_all

batch_size = 100
values = []
connection = ActiveRecord::Base.connection
timestamp = Time.now.to_s(:db)
File.open(Rails.root.join('db', 'movies.list')).each_with_index do |l, index|
  next if index < 15
  puts "Processed #{index}..." if index % 1000 == 0
  ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
  valid_string = ic.iconv(l + ' ')[0..-2]
  title = valid_string.scan(/\"(.*)\"/).flatten.first
  next if valid_string.include?("{") || valid_string.include?("(V)") || valid_string.include?("(TV)") || valid_string.include?("(VG)")
  next if title.blank?
  values << "(#{connection.quote(title)}, #{connection.quote(timestamp)}, #{connection.quote(timestamp)})"

  if values.length % batch_size == 0
    puts "Inserted #{values.length} records..."
    connection.execute "INSERT INTO movies (title, created_at, updated_at) values #{values.join(', ')}"
    values = []
  end
end

if values.any?
  puts "Inserted #{values.length} records..."
  connection.execute "INSERT INTO movies (title, created_at, updated_at) values #{values.join(', ')}"
end

puts "Imported #{Movie.count} records"
