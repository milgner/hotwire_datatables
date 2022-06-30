# frozen_string_literal: true

class Author < ApplicationRecord
  has_and_belongs_to_many :books
end
