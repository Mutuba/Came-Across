# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def up
    create_table :comments do |t|
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :comments, if_exists: true
  end
end