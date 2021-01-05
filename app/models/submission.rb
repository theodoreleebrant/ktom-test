# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :question

  delegate :contest, to: :question

  before_save :update_marks

  default_scope { order(question_id: :asc) }

  validates :answer, presence: true, on: :save

  def allow_only_single_submission
    return unless Submission.where(user_id: user_id).where(question_id: question_id).any?
    errors.add(:question_id, 'You have already submitted this question')
  end

  def update_marks
    self.marks = question.answer == answer ? question.maximum_score : 0
  end

  def self.join_questions(user_id, contest_id)
    where(user_id: user_id).includes(:question).where(questions: { contest_id: contest_id })
  end

end
