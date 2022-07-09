# frozen_string_literal: true

class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :shelves

  enum status: {
    read: 'read',
    unread: 'unread'
  }
end
