# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    name { 'Paris France' }
    latitude { 40.0002 }
    longitude { 4.0002 }
  end
end
