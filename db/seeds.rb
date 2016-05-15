# This file should contain all the record creation needed
# to seed the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_file = "#{Dir.pwd}/db/data.csv"
all_business = []

CSV.foreach(csv_file, headers: true) do |row|
  all_business << Business.new(row.to_h)
end

Business.import(all_business)
