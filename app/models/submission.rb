class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :contest

  before_save :update_marks

  default_scope { order(question_id: :asc) }

  validates :user_id, presence: true
  validates :question_id, presence: true
  # validate :allow_only_single_submission, on: :create

  def allow_only_single_submission
    if Submission.where(user_id: user_id).where(question_id: question_id).any?
      errors.add(:questiion_id, "You have already submitted this question")
    end
  end

  def update_marks
    self.marks = (self.question.answer == self.answer) ? self.question.maximum_score : 0
  end
end
