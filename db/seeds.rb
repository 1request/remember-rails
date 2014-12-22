# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
u1 = User.create(nickname: 'joe', device_id: 'FD8F9FFC-8AFA-4DDC-8DC9-64C111E065F3', device_token: '2bb9002c7198bd7ae4159aa7e4f055d83bcef2d84239f3c4df26ed9e9014d999', device_type: 'iOS')
u2 = User.create(nickname: 'harry', device_id: '123', device_token: 'f43972392113872a9d3db77fe4f2dcdf796a483dca639c5366e5fd766842e3d7', device_type: 'iOS')
u3 = User.create(nickname: 'temp', device_id: 'temp', device_token: 'temp', device_type: 'iOS', profile_picture: File.open(File.join(Rails.root, 'public', 'profile_pictures', 'thumb', 'missing.png')))

Location.destroy_all
l1 = Location.create(longitude: 114.141581141345, latitude: 22.3347568068943)

Group.destroy_all
g1 = Group.create(creator: u2, location: l1, name: 'Group1', :private => true)

Membership.destroy_all
