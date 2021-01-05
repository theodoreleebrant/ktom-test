# frozen_string_literal: true

class Contest < ApplicationRecord
  has_many :questions
  has_many :submissions, through: :questions
  accepts_nested_attributes_for :submissions, update_only: true
  validates :name, presence: true
end
