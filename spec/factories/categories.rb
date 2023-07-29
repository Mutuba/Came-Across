# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::TvShows::GameOfThrones.character }
  end
end
