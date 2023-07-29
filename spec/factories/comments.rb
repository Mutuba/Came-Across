# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :location, factory: :location
    content { 'I loved the place' }
  end
end
