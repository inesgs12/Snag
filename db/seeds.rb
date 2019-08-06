# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Keg.destroy_all
Floor.destroy_all
User.destroy_all
Location.destroy_all
Request.destroy_all
Beer.destroy_all

pale = Beer.create(name: 'London Pale Ale', abv: 4.3, description: 'British and American hops unite to make a sessionable pale ale that’s packed with citrus lager flavour. Now that’s a special relationship.', image: "pale-ale.png")
lager = Beer.create(name: 'London Lager', abv: 4.5, description: 'East Anglian malt and Goldings hops combine for a crisp, refreshing lager that’s full of flavour. A modern classic, straight from London’s back garden.', image: "lager.png")
red = Beer.create(name: 'Yakima Red Ale', abv: 4.1, description: 'British and German malts team up with five Yakima Valley American hops to create a vibrant and fruity red ale. As lively and colourful as the people that brew it.', image: "red-ale.png")
cyder = Beer.create(name: 'Aspall Draught Cyder', abv: 5.5, description: 'Lovely with sweet & sour pork, balti and bhuna mild curries, chicken with tomato & sweet red peppers, and Bramley apple pie.', image: "cider.jpg")

Location.create(name: "the Mod 1 area")
Location.create(name: "the Mod 2 area")
Location.create(name: "the Mod 3 area")
Location.create(name: "the Mod 4 area")
Location.create(name: "the Mod 5 area")
Location.create(name: "the Staff area")
Location.create(name: "the TCF area by Mods 1 & 2")
Location.create(name: "the TCF area by Mods 3, 4 & 5")
Location.create(name: "Borg")
Location.create(name: "Turing")
Location.create(name: "Fox")
Location.create(name: "the lounge between Mods 2 & 3")
Location.create(name: "the kitchen")
Location.create(name: "the main lounge")
Location.create(name: "Lovelace")
Location.create(name: "Berners-Lee")

f0 = Floor.create(floor_number:0, cups:3)
f5 = Floor.create(floor_number:5, cups:3)

Keg.create(floor:f0, beer:lager, status:3)
Keg.create(floor:f0, beer:pale, status:3)
Keg.create(floor:f0, beer:red, status:3)
Keg.create(floor:f0, beer:cyder, status:3)
Keg.create(floor:f5, beer:lager, status:3)
Keg.create(floor:f5, beer:pale, status:3)

status = ["open", "bailed", "cancelled", "in progress"]