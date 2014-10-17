# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
default = User.new(email: 'default@localhost', password: 'test', role_id: 'Administrator')
default.save

# Create Roles...
admin = Role.new(name: 'Administrator')
admin.save

user = Role.new(name: 'User')
user.save