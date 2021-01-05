# frozen_string_literal: true

class Question < ApplicationRecord
  before_create :set_question_number
  has_many :submissions
  belongs_to :contest

  validates :maximum_score, :question_number, presence: true, :numericality => { :greater_than_or_equal_to => 1 }, on: :save
  validates :problem, :answer, presence: true

  def set_question_number
    previous_number = Question.where(contest_id: contest_id).maximum(:question_number)
    p previous_number
    self.question_number = previous_number.nil? ? 1 : previous_number + 1
  end
end
