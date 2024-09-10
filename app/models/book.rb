# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :user
  validates :title, presence: true
end

