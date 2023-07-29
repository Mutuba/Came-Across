# frozen_string_literal: true

class ChangeDataTypeForRatings < ActiveRecord::Migration[7.0]
  def self.up
    change_table :locations do |t|
      t.change :ratings, :jsonb, null: false, default: {}
    end
  end

  def self.down
    change_table :locations do |t|
      t.change :ratings, :json, null: false, default: {}
    end
  end
end
