# frozen_string_literal: true

class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates_presence_of :name, :latitude, :longitude
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, reject_if: :reject_blank_comment, allow_destroy: true

  before_validation :process_ratings

  def self.update_categories
    const_set(:CATEGORIES, Category.pluck(:name).freeze)
  end

  update_categories

  def process_ratings
    ratings_data = ratings.reject { |_, value| value.blank? }
    self.ratings = {} if ratings_data.blank?

    return if ratings_data.blank?

    CATEGORIES.each do |category|
      rating = ratings_data[category]
      ratings_data[category] = rating.to_i if rating.present?
    end
    self.ratings = ratings_data
  end

  private

  def reject_blank_comment(attributes)
    attributes['content'].blank?
  end
end
