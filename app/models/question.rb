class Question < ApplicationRecord
  belongs_to :contest, dependent: :destroy

  validates :question_number, presence: true
  validate :contiguous_question_number

  def contiguous_question_number
    if question_number != 1 && !Question.where(contest_id: contest_id).find_by_question_number(question_number - 1)
      errors.add(:question_number, "Question number must be consecutive starting from 1")
    end
  end
end
