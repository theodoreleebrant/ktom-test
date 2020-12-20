class Question < ApplicationRecord
  before_create :set_question_number

  belongs_to :contest

  validates :maximum_score, presence: true
  # validate :contiguous_question_number

  # def contiguous_question_number
  #   if question_number != 1 && !Question.where(contest_id: contest_id).find_by_question_number(question_number - 1)
  #     errors.add(:question_number, "Question number must be consecutive starting from 1")
  #   elsif Question.where(contest_id: contest_id).find_by_question_number(question_number)
  #      errors.add(:question_number, "Question with this number already exists.")
  #   end
  # end
  #
  def set_question_number
    previous_number = Question.where(contest_id: contest_id).maximum(:question_number)
    p previous_number
    self.question_number = previous_number.nil? ? 1 : previous_number + 1
  end

end
