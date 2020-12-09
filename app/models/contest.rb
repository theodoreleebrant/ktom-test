class Contest < ApplicationRecord
  has_many :questions
  has_many :submissions
end
