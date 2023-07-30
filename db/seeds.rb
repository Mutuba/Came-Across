# frozen_string_literal: true

# db/seeds.rb
name = 'Hôtel Martinez - The Unbound Collection by Hyatt'
address = '73 Bd de la Croisette, 06400 Cannes'
Location.create!(name: name, address: address, latitude: 43.5512114, longitude: 7.0181816)

name = 'Exclusive Hotel Belle Plage'
address = '2 Rue Brougham, 06400 Cannes'
Location.create!(name: name, address: address, latitude: 43.5497842, longitude: 7.0068859)

name = 'Best Western Premier Le Patio des Artistes - Cannes'
address = '6 Rue de Bône, 06400 Cannes'
Location.create!(name: name, address: address, latitude: 43.5521568, longitude: 7.0288897)

name = 'Le Negresco'
address = '37 Prom. des Anglais, 06000 Nice'
Location.create!(name: name, address: address, latitude: 43.6946784, longitude: 7.2583717)

name = 'Caesars Palace'
address = '3570 S Las Vegas Blvd, Las Vegas, NV 89109, United States'
Location.create!(name: name, address: address, latitude: 36.1167079, longitude: -115.17518961139646)

# Seed predefined categories

Category.create!(name: 'Landscape')
Category.create!(name: 'People')
Category.create!(name: 'Food')
