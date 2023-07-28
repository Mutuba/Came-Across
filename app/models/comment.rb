class Comment < ApplicationRecord

  belongs_to :location
  has_rich_text :content

  validates :content, presence: true

end