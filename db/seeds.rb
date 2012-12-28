# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    admin = User.new(first: 'Admin', last: 'admin', email: 'admin@admin.com' , password: 'admin123' )
    admin.admin = true
    puts "Created admin user" if admin.save
