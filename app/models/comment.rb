# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :location
  has_rich_text :content

  validates :content, presence: true

  paginates_per 4
end
