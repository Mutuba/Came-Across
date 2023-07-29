# frozen_string_literal: true

class ChangeDataTypeForDates < ActiveRecord::Migration[7.0]
  def self.up
    change_table :locations do |t|
      t.change :dates, :datetime, precision: 6, null: true
    end
  end

  def self.down
    change_table :locations do |t|
      t.change :dates, :dates
    end
  end
end
