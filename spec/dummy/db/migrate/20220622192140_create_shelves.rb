# frozen_string_literal: true

class CreateShelves < ActiveRecord::Migration[7.0]
  def change
    create_table :shelves do |t|
      t.string :name

      t.timestamps
    end

    create_table :books_shelves, primary_key: false do |t|
      t.references :book
      t.references :shelf
    end
  end
end
