# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

mister_gun = User.create(name: 'Mister Gun', password: 'foo')
burnzoire = User.create(name: 'Burnzoire', password: 'foo')
hercy = User.create(name: 'Hercy', password: 'foo')
itch = User.create(name: 'Itch', password: 'foo')


Organisation.create(name: 'Games Ranch') do |organisation|
  Forum.create(name: 'General Discussion', organisation: organisation) do |forum|
    Topic.create(title: 'Sonic Mania', forum: forum, user: hercy)
    Topic.create(title: 'Of Shadows and Unending Echoes (documentary)', forum: forum, user: hercy)
    Topic.create(title: 'Feminist infiltration of the game industry', forum: forum, user: mister_gun)
    Topic.create(title: 'PETRICK: PREY 2', forum: forum, user: burnzoire)
  end
  Forum.create(name: 'Online Gaming', organisation: organisation) do |forum|
    Topic.create(title: "MNR '13. Forza 4. 8.30pm Syd/Melb.", forum: forum, user: hercy)
    Topic.create(title: 'GTAO', forum: forum, user: mister_gun)
    Topic.create(title: 'STEAM ID', forum: forum, user: burnzoire)
  end
  Forum.create(name: 'Off Topic', organisation: organisation) do |forum|
    Topic.create(title: 'The Youtube thread.', forum: forum, user: burnzoire)
    Topic.create(title: 'Game of Thrones [TV HBO]', forum: forum, user: hercy)
    Topic.create(title: 'The Official Thread of Seeking the Truth.', forum: forum, user: itch)
  end
end
