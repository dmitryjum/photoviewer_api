# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

list = CSV.read("#{Rails.root}/lib/assets/image_urls.csv").flatten
list.shift
list.each do |u|
  split_u = u.split('/')
  url = split_u.first(5).join('/')
  dims = split_u.last(2).join('/')
  img = Image.find_or_create_by!(url: url)
  img.dimensions << dims
  img.save!
end
