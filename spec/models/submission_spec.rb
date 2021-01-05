require 'rails_helper'

RSpec.describe Submission, type: :model do
  subject {
    described_class.new(
      user_id: User.first.id,
      question_id: Question.first.id,
      answer: "test answer"
    )
  }

  it "is valid with valid inputs" do
    expect(subject).to be_valid
  end
end
