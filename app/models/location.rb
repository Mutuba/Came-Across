# frozen_string_literal: true

class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates_presence_of :name, :latitude, :longitude
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, reject_if: :reject_blank_comment, allow_destroy: true

  before_validation :process_ratings

  paginates_per 10

  def self.update_categories
    const_set(:CATEGORIES, Category.pluck(:name).freeze)
  end

  update_categories

  private

  def process_ratings
    ratings_data = ratings.reject { |_, value| value.blank? }
    self.ratings = {} if ratings_data.blank?

    return if ratings_data.blank?

    transformed_hash = ratings_data.transform_values(&:to_i)
    CATEGORIES.each do |category|
      rating = transformed_hash[category]
      transformed_hash[category] = rating if rating.present?
    end

    self.ratings = transformed_hash
  end

  def reject_blank_comment(attributes)
    attributes['content'].blank?
  end
end
