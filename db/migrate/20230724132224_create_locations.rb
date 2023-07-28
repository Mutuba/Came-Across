# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :address
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.date :dates

      t.timestamps
    end
    add_index :locations, :latitude
    add_index :locations, :longitude
  end
end
