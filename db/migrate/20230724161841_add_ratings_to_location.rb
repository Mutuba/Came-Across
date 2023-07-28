# frozen_string_literal: true

class AddRatingsToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :ratings, :json, default: {}, null: false
  end
end
