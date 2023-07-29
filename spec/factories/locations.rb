# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    name { 'Best Western Premier Le Patio des Artistes - Cannes' }
    latitude { 43.5521568 }
    longitude { 7.0288897 }
    address { '6 Rue de Bône, 06400 Cannes' }
  end
end
