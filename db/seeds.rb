# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.where(name: 'TeleFellas').first_or_create do |u|
  u.password = 'magicfellas'
  u.email = 'distribuidos@magic.com'
end

Deck.create user_id: user.id, cards: Requester.cards['data'].sample(60), name: 'Deck 1'
Deck.create user_id: user.id, cards: Requester.cards['data'].sample(60), name: 'Deck 2'
Deck.create user_id: user.id, cards: [], name: 'Deck 3'