# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :books do |t|
      t.string :title
      t.timestamps
    end

    create_table :authors_books, primary_key: false do |t|
      t.references :author
      t.references :book
    end

    create_table :books_genres, primary_key: false do |t|
      t.references :book
      t.references :genre
    end
  end
end
