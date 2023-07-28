# frozen_string_literal: true

class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates_presence_of :name, :latitude, :longitude
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, reject_if: :reject_blank_comment, allow_destroy: true

  serialize :ratings, Hash

  def self.update_categories
    const_set(:CATEGORIES, Category.pluck(:name).freeze)
  end

  update_categories

  def ratings=(value)
    ratings_data = {}
    CATEGORIES.each do |category|
      rating = value[category]
      ratings_data[category] = rating.to_i if rating.present?
    end
    self[:ratings] = ratings_data
  end

  private

  def reject_blank_comment(attributes)
    attributes['content'].blank?
  end
end
